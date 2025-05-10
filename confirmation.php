<?php
// Include DB connection
include("db.php");
session_start();

// Image handling configuration
define('UPLOAD_DIR', 'Uploads/');
define('DEFAULT_IMAGE', 'assets/default-candidate.png');
define('ALLOWED_EXTENSIONS', ['jpg', 'jpeg', 'png', 'gif']);

// Error logging function
function logError($message) {
    if (defined('DEBUG_MODE') && DEBUG_MODE) {
        error_log("[Voting System] " . $message);
    }
}

// Helper function to validate image paths
function isValidImage($path) {
    if (empty($path)) {
        logError("Empty image path detected");
        return false;
    }
    
    $extension = strtolower(pathinfo($path, PATHINFO_EXTENSION));
    if (!in_array($extension, ALLOWED_EXTENSIONS)) {
        logError("Invalid extension for file: " . $path);
        return false;
    }
    
    if (!file_exists($path)) {
        logError("File does not exist: " . $path);
        return false;
    }
    
    return true;
}

// Helper function to get image path
function getImagePath($dbPath) {
    $dbPath = str_replace(['\\', '"'], ['/', ''], trim($dbPath));
    
    if (isValidImage($dbPath)) {
        return $dbPath;
    }
    
    $fullPath = UPLOAD_DIR . basename($dbPath);
    if (isValidImage($fullPath)) {
        return $fullPath;
    }
    
    logError("Using default image for path: " . $dbPath);
    return DEFAULT_IMAGE;
}

if (!isset($_SESSION['user_id'])) {
    header("Location: index.php");
    exit();
}

$user_id = $_SESSION['user_id'];

// Fetch voter's details
$voter_query = $conn->prepare("SELECT name, voter_id FROM voters WHERE id = ?");
$voter_query->bind_param("i", $user_id);
$voter_query->execute();
$voter_result = $voter_query->get_result();

if ($voter_result->num_rows > 0) {
    $voter = $voter_result->fetch_assoc();
    $voter_name = $voter['name'];
    $voter_id = $voter['voter_id'];
} else {
    die("Voter not found.");
}

// Modify the vote counts query to get the leading candidate
$candidateVotes = $conn->query("
    SELECT 
        candidates.name,
        candidates.politic_name,
        candidates.image_path,
        COUNT(votes.candidate_id) AS vote_count,
        RANK() OVER (ORDER BY COUNT(votes.candidate_id) DESC) as position
    FROM candidates
    LEFT JOIN votes ON candidates.id = votes.candidate_id
    GROUP BY candidates.id
    ORDER BY vote_count DESC
");

if (!$candidateVotes) {
    logError("Error fetching vote counts: " . $conn->error);
    die("Error loading vote counts. Please try again later.");
}

// Get the leading candidate
$leadingCandidate = null;
if ($row = $candidateVotes->fetch_assoc()) {
    $leadingCandidate = $row;
    // Reset the pointer for later use
    $candidateVotes->data_seek(0);
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thank You for Voting!</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    
    <!-- AOS - Animate On Scroll Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        :root {
            --saffron: #FF9933;
            --white: #FFFFFF;
            --green: #138808;
            --red: #c0392b;
            --primary-gradient: linear-gradient(135deg, var(--saffron), var(--green));
            --box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, 
                rgba(255,153,51,0.05) 0%, 
                rgba(255,255,255,0.1) 50%, 
                rgba(19,136,8,0.05) 100%);
            overflow-x: hidden;
        }
        
        .main-title {
            @apply text-5xl font-bold text-center my-10;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .leader-card {
            @apply relative overflow-hidden rounded-2xl transition-all duration-500;
            background: rgba(255, 255, 255, 0.95);
            box-shadow: var(--box-shadow);
            transform: perspective(1000px) rotateY(0deg);
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        
        .leader-card:hover {
            transform: perspective(1000px) rotateY(5deg) translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.15);
        }
        
        .leader-image {
            @apply rounded-full border-4 mx-auto;
            border-color: var(--saffron);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            transition: all 0.5s ease;
            height: 120px;
            width: 120px;
            object-fit: cover;
        }
        
        .leader-card:hover .leader-image {
            transform: scale(1.1) rotate(5deg);
            border-color: var(--green);
        }
        
        .candidate-item {
            @apply relative flex items-center p-6 my-4 rounded-xl transition-all duration-300;
            background: linear-gradient(135deg, rgba(255, 153, 51, 0.03), rgba(19, 136, 8, 0.03));
            border: 1px solid rgba(0, 0, 0, 0.05);
        }
        
        .candidate-item:hover {
            @apply transform translate-x-3 scale-[1.01];
            background: linear-gradient(135deg, rgba(255, 153, 51, 0.07), rgba(19, 136, 8, 0.07));
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
        }
        
        .candidate-position {
            @apply absolute flex items-center justify-center w-12 h-12 text-white font-bold rounded-full;
            background: var(--primary-gradient);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            left: -15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.2rem;
        }
        
        .candidate-image {
            @apply rounded-full object-cover border-4 transition-all duration-300;
            border-color: var(--white);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            height: 100px;
            width: 100px;
        }
        
        .candidate-item:hover .candidate-image {
            transform: scale(1.05);
            border-color: var(--saffron);
        }
        
        .vote-count-badge {
            @apply relative px-6 py-4 rounded-xl overflow-hidden;
            background: linear-gradient(145deg, #ffffff, #f0f0f0);
            border: 2px solid transparent;
            background-clip: padding-box;
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
            transition: all 0.4s ease;
            min-width: 160px;
            text-align: center;
            position: relative;
            z-index: 1;
        }
        
        .vote-count-badge::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: var(--primary-gradient);
            z-index: -1;
            opacity: 0;
            transition: opacity 0.4s ease;
        }
        
        .vote-count-badge:hover {
            transform: translateY(-8px) scale(1.03);
            box-shadow: 0 12px 30px rgba(0,0,0,0.2);
            border-color: transparent;
        }
        
        .vote-count-badge:hover::before {
            opacity: 1;
        }
        
        .vote-count-badge .vote-number {
            font-size: 2rem;
            font-weight: 800;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            line-height: 1.2;
            transition: all 0.4s ease;
        }
        
        .vote-count-badge:hover .vote-number {
            -webkit-text-fill-color: #ffffff;
        }
        
        .vote-count-badge .vote-text {
            color: #555;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1.5px;
            margin-top: 0.5rem;
            transition: color 0.4s ease;
        }
        
        .vote-count-badge:hover .vote-text {
            color: #ffffff;
        }
        
        .vote-count-badge .vote-icon {
            font-size: 1.25rem;
            color: var(--saffron);
            margin-bottom: 0.5rem;
            transition: color 0.4s ease;
        }
        
        .vote-count-badge:hover .vote-icon {
            color: #ffffff;
        }
        
        .pulse-animation {
            animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        
        .video-container {
            @apply rounded-xl overflow-hidden mx-auto relative;
            max-width: 800px;
            transform: translateZ(0);
            transition: all 0.5s ease;
            border: 3px solid;
            border-image: linear-gradient(to right, var(--saffron), var(--white), var(--green)) 1;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }
        
        .video-container:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }
        
        @keyframes videoPulse {
            0% { box-shadow: 0 0 0 0 rgba(255, 153, 51, 0.7), 0 0 0 0 rgba(19, 136, 8, 0.7); }
            50% { box-shadow: 0 0 20px 5px rgba(255, 153, 51, 0.4), 0 0 20px 5px rgba(19, 136, 8, 0.4); }
            100% { box-shadow: 0 0 0 0 rgba(255, 153, 51, 0), 0 0 0 0 rgba(19, 136, 8, 0); }
        }
        
        .video-pulse {
            animation: videoPulse 2s infinite;
        }
        
        .video-section {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 3rem auto;
            padding: 1rem;
        }
        
        .video-controls {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 1rem;
            background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        
        .video-container:hover .video-controls {
            opacity: 1;
        }
        
        .control-button {
            background: rgba(255,255,255,0.2);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }
        
        .control-button:hover {
            background: rgba(255,255,255,0.3);
            transform: scale(1.1);
        }
        
        .team-member {
            animation: fadeInUp 0.6s ease-out forwards;
            animation-delay: calc(var(--member-index) * 0.1s);
        }
        
        .team-member:hover .member-avatar {
            animation: floatAnimation 2s ease-in-out infinite;
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes floatAnimation {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }
        :root {
            --saffron: #FF9933;
            --green: #138808;
            --white: #FFFFFF;
            --red: #c0392b;
            --footer-gradient: linear-gradient(135deg, #1e3a8a, #4f46e5);
        }

        footer {
            background: var(--footer-gradient);
            color: var(--white);
            width: 100%;
            padding: 4rem 1rem 2rem;
            position: relative;
            margin-top: auto;
            overflow: hidden;
        }

        .footer-parallax {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"%3E%3Cpath fill="%231e3a8a" fill-opacity="0.3" d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,112C672,96,768,96,864,112C960,128,1056,160,1152,160C1248,160,1344,128,1392,112L1440,96L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"%3E%3C/path%3E%3C/svg%3E') repeat-x bottom;
            transform: translateY(0);
            transition: transform 0.1s ease;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
            text-align: center;
        }

        .footer-brand {
            margin-bottom: 2rem;
        }

        .footer-brand h2 {
            font-size: 2.2rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--white), #93c5fd);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            animation: glow 2s ease-in-out infinite;
        }

        .footer-brand p {
            font-size: 1rem;
            color: rgba(255, 255, 255, 0.9);
            margin-top: 0.5rem;
        }

        .footer-team {
            margin: 2rem 0;
        }

        .team-members {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
            gap: 1.5rem;
            padding: 1rem;
        }

        .team-member {
            background: rgba(255, 255, 255, 0.1);
            padding: 1.5rem;
            border-radius: 12px;
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
        }

        .team-member:hover {
            transform: translateY(-8px) scale(1.03);
            background: rgba(255, 255, 255, 0.2);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .member-avatar {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #3b82f6, #1e3a8a);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            transition: transform 0.3s ease;
        }

        .team-member:hover .member-avatar {
            transform: rotate(10deg);
        }

        .team-member h4 {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .team-member p {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.8);
        }

        .footer-social {
            margin: 2rem 0;
        }

        .social-links {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
        }

        .social-links a {
            width: 48px;
            height: 48px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-size: 1.2rem;
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            transform: scale(1.2) rotate(15deg);
            background: rgba(255, 255, 255, 0.3);
            box-shadow: 0 0 15px rgba(255, 255, 255, 0.5);
        }

        .footer-copyright {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.8);
            padding-top: 1rem;
            position: relative;
        }

        .footer-copyright::before {
            content: '';
            position: absolute;
            top: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 2px;
            background: rgba(255, 255, 255, 0.3);
        }

        .footer-copyright i {
            color: #ef4444;
        }

        .footer-wave {
            position: absolute;
            top: -60px;
            left: 0;
            width: 100%;
            height: 60px;
            overflow: hidden;
            z-index: 0;
        }

        .wave-path {
            fill: rgba(255, 255, 255, 0.1);
            animation: waveMove 10s linear infinite;
        }

        @keyframes glow {
            0% { text-shadow: 0 0 5px rgba(255, 255, 255, 0.5); }
            50% { text-shadow: 0 0 15px rgba(255, 255, 255, 0.8); }
            100% { text-shadow: 0 0 5px rgba(255, 255, 255, 0.5); }
        }

        @keyframes waveMove {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }

        @media (max-width: 768px) {
            .footer-brand h2 { font-size: 1.5rem; }
            .team-members { grid-template-columns: repeat(auto-fit, minmax(140px, 1fr)); }
            footer { padding: 3rem 1rem 1rem; }
        }
    </style>
</head>

<body>
<div class="container text-center p-5 bg-white shadow-lg rounded-lg">
    <h1 class="display-3 font-bold text-primary text-4xl md:text-5xl lg:text-6xl">
        Thank You for Voting!
    </h1>
    <p class="lead text-success text-xl md:text-2xl mt-3">
        Your vote has been recorded successfully.
    </p>
    <p class="text-lg text-gray-700 mt-2">
        Here are the current results:
    </p>
</div>

<!-- Voter Information Banner -->
<div class="bg-gradient-to-r from-orange-100 to-green-100 rounded-lg p-4 mb-8 shadow-md animate__animated animate__fadeInDown">
    <div class="flex flex-wrap items-center justify-between">
        <div class="flex items-center">
            <i class="fas fa-user-check text-orange-500 text-2xl mr-3"></i>
            <div>
                <h3 class="font-medium">Voter:</h3>
                <p class="text-gray-700"><?= htmlspecialchars($voter_name) ?> (ID: <?= htmlspecialchars($voter_id) ?>)</p>
            </div>
        </div>
        <div class="mt-2 md:mt-0">
            <span class="bg-green-500 text-white px-3 py-1 rounded-full text-sm flex items-center">
                <i class="fas fa-check-circle mr-1"></i> Vote Confirmed
            </span>
        </div>
    </div>
</div>

<!-- Leading Candidate Section -->
<?php if ($leadingCandidate): ?>
<div data-aos="fade-up" data-aos-duration="1000">
    <div class="leader-card p-6 mb-10">
        <div class="text-center mb-4">
            <h2 class="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-orange-500 to-green-600">
                Current Leading Candidate
            </h2>
            <div class="h-1 w-24 bg-gradient-to-r from-orange-500 to-green-600 mx-auto mt-2 rounded-full"></div>
        </div>
        
        <div class="flex flex-col md:flex-row items-center justify-center gap-8 p-4">
            <div class="relative">
                <img 
                    src="<?= htmlspecialchars(getImagePath($leadingCandidate['image_path'])) ?>" 
                    alt="Leading candidate" 
                    class="leader-image pulse-animation"
                    onerror="this.src='<?= DEFAULT_IMAGE ?>'"
                >
                <div class="absolute -top-3 -right-3 bg-green-500 text-white rounded-full w-10 h-10 flex items-center justify-center shadow-lg">
                    <i class="fas fa-trophy"></i>
                </div>
            </div>
            
            <div class="text-center md:text-left">
                <h3 class="text-3xl font-bold text-gray-800 mb-2"><?= htmlspecialchars($leadingCandidate['name']) ?></h3>
                <p class="text-xl text-gray-600 mb-4"><?= htmlspecialchars($leadingCandidate['politic_name']) ?></p>
                
                <div class="vote-count-badge inline-block">
                    <i class="fas fa-poll vote-icon"></i>
                    <div class="vote-number"><?= number_format($leadingCandidate['vote_count']) ?></div>
                    <div class="vote-text">TOTAL VOTES</div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php endif; ?>

<!-- Vote Results Section -->
<div data-aos="fade-up" data-aos-duration="1000" data-aos-delay="200" class="bg-white rounded-2xl p-8 shadow-lg mb-10">
    <div class="text-center mb-8">
        <h2 class="text-3xl font-bold text-gray-800">Current Vote Standings</h2>
        <p class="text-gray-600 mt-2">
            <i class="fas fa-chart-line mr-2 text-green-600"></i> Real-time election results
        </p>
        <div class="h-1 w-24 bg-gradient-to-r from-orange-500 to-green-600 mx-auto mt-4 rounded-full"></div>
    </div>
    
    <div class="space-y-6">
        <?php $delay = 0; $candidateVotes->data_seek(0); ?>
        <?php while ($row = $candidateVotes->fetch_assoc()): ?>
        <div data-aos="fade-right" data-aos-duration="800" data-aos-delay="<?= $delay * 100 ?>" 
             class="flex items-center bg-gray-100 p-4 rounded-lg shadow-sm transition-transform hover:scale-105">
            
            <!-- Candidate Position Badge -->
            <div class="candidate-position bg-gradient-to-r from-orange-500 to-green-600 text-white px-3 py-1 rounded-full text-sm font-semibold">
                <?= htmlspecialchars($row['position']) ?>
            </div>

            <!-- Candidate Image -->
            <img 
                src="<?= htmlspecialchars(getImagePath($row['image_path'])) ?>" 
                alt="<?= htmlspecialchars($row['name']) ?>" 
                class="candidate-image rounded-full shadow-md border-2 border-gray-300 w-16 h-16 object-cover mx-4"
                onerror="this.src='<?= DEFAULT_IMAGE ?>'"
                loading="lazy"
            >

            <!-- Candidate Details -->
            <div class="flex flex-grow justify-between items-center w-full">
                <div class="flex-1">
                    <h3 class="text-xl font-semibold text-gray-800">
                        <?= htmlspecialchars($row['name']) ?>
                    </h3>
                    <p class="text-gray-600 text-sm">
                        <?= htmlspecialchars($row['politic_name']) ?>
                    </p>
                </div>

                <!-- Vote Count Badge -->
                <div class="vote-count-badge flex-shrink-0">
                    <i class="fas fa-poll vote-icon"></i>
                    <div class="vote-number"><?= number_format($row['vote_count']) ?></div>
                    <div class="vote-text">TOTAL VOTES</div>
                </div>
            </div>
        </div>
        <?php $delay += 0.2; ?>
        <?php endwhile; ?>
    </div>
</div>

<!-- Video Section with Center Alignment and Enhanced Styling -->
<div class="video-section" data-aos="zoom-in" data-aos-duration="1000">
    <div class="video-container video-pulse">
        <video id="resultVideo" class="w-full" autoplay loop playsinline>
            <source src="Uploads/Voting Results.mp4" type="video/mp4">
            Your browser does not support the video tag.
        </video>
        
        <!-- Enhanced Video Controls -->
        <div class="video-controls">
            <div class="flex justify-between items-center text-white">
                <button id="playPauseBtn" class="control-button focus:outline-none">
                    <i class="fas fa-pause"></i>
                </button>
                <button id="muteBtn" class="control-button focus:outline-none">
                    <i class="fas fa-volume-up"></i>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Back to Home Button -->
<div class="text-center my-10">
    <a href="index.php" class="inline-block bg-gradient-to-r from-orange-500 to-green-600 text-white font-bold py-3 px-8 rounded-full shadow-lg hover:shadow-xl transform transition-all duration-300 hover:-translate-y-1 animate__animated animate__pulse animate__infinite">
        <i class="fas fa-home mr-2"></i> Back to Home
    </a>
</div>

<footer class="relative bg-gradient-to-r from-indigo-900 to-blue-600 text-white w-full py-16 px-4 overflow-hidden">
    <!-- Wave Animation -->
    <div class="footer-wave">
        <svg viewBox="0 0 1440 60" preserveAspectRatio="none" class="w-full h-full">
            <path class="wave-path" d="M0,60C240,30,480,0,720,0s480,30,720,0V60H0Z" fill="rgba(255,255,255,0.1)"/>
        </svg>
    </div>

    <!-- Parallax Background -->
    <div class="footer-parallax"></div>

    <!-- Footer Content -->
    <div class="footer-content max-w-7xl mx-auto relative z-10">
        <!-- Brand Section -->
        <div class="footer-brand text-center mb-12" data-aos="fade-up" data-aos-duration="1000">
            <h2 class="text-4xl md:text-5xl font-bold animate__animated animate__pulse animate__infinite animate__slow">
                Voting System
            </h2>
            <div class="mt-6 bg-white bg-opacity-10 rounded-lg p-4 max-w-2xl mx-auto" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="200">
                <p class="text-lg md:text-xl font-semibold">
                    Konghu Velalar Polytechnic College, Seenapuram
                </p>
                <p class="text-sm md:text-base opacity-90 mt-2">
                    Department of Computer Science and Engineering (DCSE) - II Year
                </p>
                <p class="text-sm md:text-base opacity-90">
                    Subject: Scripting Language
                </p>
            </div>
        </div>

        <!-- Team Section -->
        <div class="footer-team mb-12" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="200">
            <h3 class="text-2xl md:text-3xl font-semibold text-center mb-8">
                Our Team
            </h3>
            <div class="team-members">
                <div class="team-member" style="--member-index: 1" data-aos="fade-up" data-aos-delay="100">
                    <div class="member-avatar">
                        <i class="fas fa-user fa-2x text-white"></i>
                    </div>
                    <h4 class="text-lg font-semibold">Jeevasurya P</h4>
                    <p class="text-sm opacity-80">Project Head</p>
                </div>
                <div class="team-member" style="--member-index: 2" data-aos="fade-up" data-aos-delay="200">
                    <div class="member-avatar">
                        <i class="fas fa-user fa-2x text-white"></i>
                    </div>
                    <h4 class="text-lg font-semibold">Hariharan R</h4>
                    <p class="text-sm opacity-80">Lead Developer</p>
                </div>
                <div class="team-member" style="--member-index: 3" data-aos="fade-up" data-aos-delay="300">
                    <div class="member-avatar">
                        <i class="fas fa-user fa-2x text-white"></i>
                    </div>
                    <h4 class="text-lg font-semibold">Gokulraj M</h4>
                    <p class="text-sm opacity-80">UI/UX Designer</p>
                </div>
                <div class="team-member" style="--member-index: 4" data-aos="fade-up" data-aos-delay="400">
                    <div class="member-avatar">
                        <i class="fas fa-user fa-2x text-white"></i>
                    </div>
                    <h4 class="text-lg font-semibold">Inbaraj V</h4>
                    <p class="text-sm opacity-80">Backend Developer</p>
                </div>
                <div class="team-member" style="--member-index: 5" data-aos="fade-up" data-aos-delay="500">
                    <div class="member-avatar">
                        <i class="fas fa-user fa-2x text-white"></i>
                    </div>
                    <h4 class="text-lg font-semibold">Mathan R</h4>
                    <p class="text-sm opacity-80">Security Specialist</p>
                </div>
                <div class="team-member" style="--member-index: 6" data-aos="fade-up" data-aos-delay="600">
                    <div class="member-avatar">
                        <i class="fas fa-user fa-2x text-white"></i>
                    </div>
                    <h4 class="text-lg font-semibold">Harinesh N</h4>
                    <p class="text-sm opacity-80">QA Engineer</p>
                </div>
            </div>
        </div>

        <!-- Social Links -->
        <div class="footer-social mb-12" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="400">
            <h3 class="text-xl md:text-2xl font-semibold text-center mb-6">
                Connect With Us
            </h3>
            <div class="social-links">
                <a href="https://twitter.com" target="_blank" class="social-link">
                    <i class="fab fa-twitter"></i>
                </a>
                <a href="https://linkedin.com" target="_blank" class="social-link">
                    <i class="fab fa-linkedin-in"></i>
                </a>
                <a href="https://github.com" target="_blank" class="social-link">
                    <i class="fab fa-github"></i>
                </a>
                <a href="https://instagram.com" target="_blank" class="social-link">
                    <i class="fab fa-instagram"></i>
                </a>
            </div>
        </div>

        <!-- Copyright -->
        <div class="footer-copyright text-center" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="600">
            <p>
                © <span id="current-year"></span> Voting System. All rights reserved.
                <i class="fas fa-heart text-red-500"></i> Made with passion.
            </p>
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- AOS JS -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

<script>
    // Initialize AOS (Animate on Scroll)
    document.addEventListener('DOMContentLoaded', () => {
        AOS.init({
            once: false,
            mirror: true,
            offset: 100
        });
        
        // Video handling
        const video = document.getElementById('resultVideo');
        const playPauseBtn = document.getElementById('playPauseBtn');
        const muteBtn = document.getElementById('muteBtn');
        
        // Try to play video with sound (this might be blocked by browser policies)
        const playPromise = video.play();
        
        if (playPromise !== undefined) {
            playPromise.catch(error => {
                console.log("Autoplay with sound was prevented. Adding muted attribute.");
                video.muted = true;  // Fallback to muted if autoplay with sound is blocked
                muteBtn.innerHTML = '<i class="fas fa-volume-mute"></i>';
                video.play();
            });
        }
        
        // Play/Pause button functionality
        playPauseBtn.addEventListener('click', () => {
            if (video.paused) {
                video.play();
                playPauseBtn.innerHTML = '<i class="fas fa-pause"></i>';
            } else {
                video.pause();
                playPauseBtn.innerHTML = '<i class="fas fa-play"></i>';
            }
        });
        
        // Mute button functionality
        muteBtn.addEventListener('click', () => {
            video.muted = !video.muted;
            muteBtn.innerHTML = video.muted ? 
                '<i class="fas fa-volume-mute"></i>' : 
                '<i class="fas fa-volume-up"></i>';
        });

        // Parallax effect for footer
        window.addEventListener('scroll', () => {
            const footer = document.querySelector('footer');
            const parallax = document.querySelector('.footer-parallax');
            if (footer && parallax) {
                const footerRect = footer.getBoundingClientRect();
                const scrollPosition = window.scrollY + window.innerHeight;
                
                if (scrollPosition > footerRect.top + window.scrollY) {
                    const parallaxOffset = (scrollPosition - (footerRect.top + window.scrollY)) * 0.2;
                    parallax.style.transform = `translateY(-${parallaxOffset}px)`;
                }
            }
        });
    });
</script>
</body>
</html>