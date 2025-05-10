<?php
session_start();
include("db.php");

// Debug mode - set to false in production
define('DEBUG_MODE', true);

if (!isset($_SESSION['user_id'])) {
    header("Location: main.php");
    exit();
}

// Image handling configuration
define('UPLOAD_DIR', 'uploads/');
define('DEFAULT_IMAGE', 'assets/default-candidate.png');
define('ALLOWED_EXTENSIONS', ['jpg', 'jpeg', 'png', 'gif']);

// Error logging function
function logError($message) {
    if (DEBUG_MODE) {
        error_log("[Voting System] " . $message);
    }
}

// Directory permission checks
if (!is_readable(UPLOAD_DIR)) {
    logError("Upload directory is not readable: " . UPLOAD_DIR);
}

// Check if default image exists, log if not
if (!file_exists(DEFAULT_IMAGE)) {
    logError("Default image not found: " . DEFAULT_IMAGE);
}

// Helper function to validate image paths
function isValidImage($path) {
    if (empty($path)) {
        // logError("Empty image path detected"); // Can be noisy, maybe comment out unless debugging paths
        return false;
    }

    $resolvedPath = realpath($path); // Check if file actually exists at the path

    if (!$resolvedPath) {
         // logError("File does not exist or path is invalid: " . $path); // More specific log
        return false;
    }

    $extension = strtolower(pathinfo($resolvedPath, PATHINFO_EXTENSION));
    if (!in_array($extension, ALLOWED_EXTENSIONS)) {
        logError("Invalid extension for file: " . $resolvedPath);
        return false;
    }

    if (!is_readable($resolvedPath)) { // Check readability too
        logError("File is not readable: " . $resolvedPath);
        return false;
    }

    return true;
}


// Helper function to get image path
function getImagePath($dbPath) {
    // Clean up potential issues in the path from the DB
    $dbPath = str_replace(['\\', '"'], ['/', ''], trim($dbPath));

    // 1. Check if the path from DB is absolute or relative *and* valid
    if (isValidImage($dbPath)) {
        return $dbPath;
    }

    // 2. Check if the path is relative to the UPLOAD_DIR
    $uploadDirPath = rtrim(UPLOAD_DIR, '/\\'); // Ensure no trailing slash for clean join
    $fullPath = $uploadDirPath . '/' . basename($dbPath); // Construct path relative to uploads
    if (isValidImage($fullPath)) {
        return $fullPath;
    }

    // 3. If all checks fail, log the problematic path and return default
    logError("Invalid or missing image path, using default. Original path: '" . $dbPath . "', Checked path: '" . $fullPath . "'");
    return DEFAULT_IMAGE;
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
    $voter_id_string = $voter['voter_id'];
} else {
    logError("Voter not found for ID: " . $user_id);
    // Provide a more user-friendly message or redirect
    die("Error: Voter information could not be retrieved. Please log out and try again.");
}
$voter_query->close(); // Close the statement


// Check if the user has already voted
$vote_check = $conn->prepare("SELECT * FROM votes WHERE voter_id_string = ?");
$vote_check->bind_param("s", $voter_id_string);
$vote_check->execute();
$vote_result = $vote_check->get_result();

if ($vote_result->num_rows > 0) {
    $vote_check->close(); // Close the statement
    header("Location: no-repeat.php");
    exit();
}
$vote_check->close(); // Close the statement

// Check if a candidate was already selected in this session
if (isset($_SESSION['selected_candidate']) && !isset($_GET['reset'])) {
    $selected_candidate_id = $_SESSION['selected_candidate'];

    // Modify the query to only fetch the selected candidate
    $candidates_stmt = $conn->prepare("SELECT id, name, politic_name, image_path FROM candidates WHERE id = ?");
    if (!$candidates_stmt) {
        logError("Prepare failed (selected candidate): " . $conn->error);
        die("Database error preparing candidate data.");
    }
    $candidates_stmt->bind_param("i", $selected_candidate_id);
    $candidates_stmt->execute();
    $candidates = $candidates_stmt->get_result();
    if (!$candidates) {
         logError("Get result failed (selected candidate): " . $conn->error);
         die("Database error fetching candidate data.");
    }
    $candidates_stmt->close(); // Close the statement
    $selection_made = true;
} else {
    // Normal query to fetch all candidates if no selection has been made yet
    $result = $conn->query("SELECT id, name, politic_name, image_path FROM candidates");
     if (!$result) {
         logError("Query failed (all candidates): " . $conn->error);
         die("Database error fetching candidate list.");
     }
     $candidates = $result; // Assign the result object
    $selection_made = false;
    // Ensure session variable is cleared if we are resetting or haven't selected yet
    unset($_SESSION['selected_candidate']);
}

// Store the selection in session when a candidate is selected but form is not yet submitted
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['select_candidate']) && isset($_POST['candidate_id'])) {
    // Basic validation: ensure candidate_id is a number
    if (filter_var($_POST['candidate_id'], FILTER_VALIDATE_INT)) {
        $_SESSION['selected_candidate'] = intval($_POST['candidate_id']);
        // Redirect to self to refresh with only the selected candidate
        header("Location: " . $_SERVER['PHP_SELF']);
        exit();
    } else {
        logError("Invalid candidate_id received: " . $_POST['candidate_id']);
        // Optional: Add user feedback about invalid selection
    }
}

// Process the final vote submission
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['submit_vote']) && isset($_SESSION['selected_candidate'])) {
    $candidate_id = $_SESSION['selected_candidate']; // Already validated as int when set

    $stmt = $conn->prepare("INSERT INTO votes (voter_id_string, candidate_id) VALUES (?, ?)");
     if (!$stmt) {
        logError("Prepare failed (insert vote): " . $conn->error);
        die("Error processing your vote. Database preparation failed.");
    }
    $stmt->bind_param("si", $voter_id_string, $candidate_id);

    if ($stmt->execute()) {
        // Clear the selection from session after successful vote
        unset($_SESSION['selected_candidate']);
        $stmt->close(); // Close statement on success
        header("Location: confirmation.php");
        exit();
    } else {
        logError("Vote insertion failed for voter ID: " . $voter_id_string . " Error: " . $stmt->error);
        $stmt->close(); // Close statement on failure
        die("Error processing your vote. Please try again later.");
    }
}

date_default_timezone_set('Asia/Kolkata');
$current_datetime = date('d-m-Y H:i:s');
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vote for Your Candidate</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- AOS Animations -->
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        /* Custom styles that integrate with Bootstrap and Tailwind */
        :root {
            --primary-color: #3B82F6;
            --primary-dark: #2563EB;
            --secondary-color: #10B981;
            --warning-color: #EF4444;
            --light-color: #F3F4F6;
            --dark-color: #1F2937;
        }

        body {
            background-color: #F9FAFB;
            font-family: 'Inter', sans-serif; /* Ensure Inter is loaded or use a fallback */
        }

        .custom-card {
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        }

        .custom-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }

        /* Removed .candidate-radio specific styles as peer handles it */

        .time-unit {
            position: relative;
            perspective: 400px;
        }

        .time-number {
            transition: transform 0.3s ease;
        }

        .flip {
            animation: flipAnimation 0.6s ease-in-out;
            transform-origin: bottom;
        }

        .time-separator {
            animation: blink 1s infinite;
        }

        .voter-badge {
            background: linear-gradient(135deg, #6366F1, #3B82F6);
        }

        .caution-badge {
            animation: pulse 2s infinite;
        }

        .footer-wave {
            /* Styling for footer wave if using footer.php */
            position: absolute;
            bottom: 0; /* Example positioning */
            left: 0;
            width: 100%;
            height: 40px;
            background: url('wave.svg'); /* Example */
            background-repeat: repeat-x;
            animation: waveMove 10s linear infinite;
        }

        .social-icon {
            transition: all 0.3s ease;
        }

        .social-icon:hover {
            transform: translateY(-3px);
        }

        .image-loading {
            position: relative;
            opacity: 0.7;
        }

        /* Simple loading indicator */
        .image-loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin-top: -10px;
            margin-left: -10px;
            border: 2px solid rgba(255, 255, 255, 0.5);
            border-top-color: var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }


        .image-error {
            border: 3px solid var(--warning-color) !important;
            position: relative;
            background-color: #fee2e2; /* Light red background for error */
        }

        .image-error::after {
            content: '!';
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--warning-color);
            color: white;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: bold;
            box-shadow: 0 0 5px rgba(0,0,0,0.3);
        }
        h2 {
            font-size: 1.5rem; /* 24px */
            margin-bottom: 1rem; /* 16px */
            font-weight: 600;
        }
        .timer-container {
            text-align: center;
            background: linear-gradient(135deg, #6a11cb, #2575fc);
            padding: 1.5rem; /* Adjusted padding */
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            color: white;
            margin-top: 1rem; /* Added margin for spacing */
            min-width: 180px; /* Ensure minimum width */
        }

        /* Selection confirmation animation */
        @keyframes confirmPulse {
            0% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(16, 185, 129, 0); }
            100% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
        }

        .selected-candidate {
            animation: confirmPulse 2s infinite;
        }

        /* Animations */
        @keyframes flipAnimation {
            0% { transform: rotateX(0deg); }
            50% { transform: rotateX(90deg); }
            100% { transform: rotateX(0deg); }
        }

        @keyframes blink {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.05); opacity: 0.9; } /* Subtle pulse */
        }

        @keyframes waveMove {
            0% { background-position-x: 0; }
            100% { background-position-x: 1000px; } /* Adjust based on wave pattern width */
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }


        #timer {
            font-size: 2.5rem; /* Slightly smaller */
            font-weight: bold;
            color: white;
            animation: pulse 1.5s infinite ease-in-out;
            letter-spacing: 2px; /* Add spacing */
        }
    </style>
</head>
<body class="bg-gray-50">
    <div class="container mx-auto px-4 py-8">
        <!-- Voter Information Card -->
        <div class="mb-8" data-aos="fade-down" data-aos-duration="800">
            <div class="bg-white rounded-lg shadow-lg p-6 border-l-4 border-blue-500">
                <div class="flex flex-col md:flex-row justify-between items-center gap-4"> 
                    <div>
                        <h4 class="text-xl font-semibold text-gray-700 mb-3"> 
                            <i class="fas fa-user-circle text-blue-500 mr-2"></i>Voter Information
                        </h4>
                        <div class="flex flex-col sm:flex-row gap-4"> 
                            <div class="bg-blue-50 px-4 py-2 rounded-lg text-center sm:text-left"> 
                                <span class="text-sm text-gray-500 block">Name</span> 
                                <p class="font-medium text-gray-800"><?php echo htmlspecialchars($voter_name); ?></p>
                            </div>
                            <div class="bg-blue-50 px-4 py-2 rounded-lg text-center sm:text-left"> 
                                <span class="text-sm text-gray-500 block">Voter ID</span> 
                                <p class="font-medium text-gray-800"><?php echo htmlspecialchars($voter_id_string); ?></p>
                            </div>
                        </div>
                    </div>
                    <!-- Timer -->
                     <div class="timer-container mt-4 md:mt-0" data-aos="fade-left" data-aos-delay="100">
                        <h2 class="text-lg font-semibold mb-1">Timeout in:</h2>
                        <div id="timer">1:00</div>
                    </div>
                    <!-- Live Clock -->
                    <div class="mt-4 md:mt-0" data-aos="fade-left" data-aos-delay="200">
                        <div class="flex gap-2 bg-gray-800 rounded-lg p-3 text-white shadow-md">
                            <div class="bg-gray-700 px-3 py-2 rounded text-center time-unit">
                                <span class="time-number font-mono text-xl block" id="hours">00</span>
                                <span class="text-xs block text-center uppercase">Hrs</span>
                            </div>
                            <span class="time-separator self-center font-bold text-xl mx-1">:</span>
                            <div class="bg-gray-700 px-3 py-2 rounded text-center time-unit">
                                <span class="time-number font-mono text-xl block" id="minutes">00</span>
                                <span class="text-xs block text-center uppercase">Min</span>
                            </div>
                            <span class="time-separator self-center font-bold text-xl mx-1">:</span>
                            <div class="bg-gray-700 px-3 py-2 rounded text-center time-unit">
                                <span class="time-number font-mono text-xl block" id="seconds">00</span>
                                <span class="text-xs block text-center uppercase">Sec</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Caution Message -->
        <div class="mb-8" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="200">
            <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded-md shadow-sm caution-badge" role="alert">
                 <div class="flex items-center">
                    <div class="py-1"><i class="fas fa-exclamation-triangle text-2xl text-red-500 mr-3"></i></div>
                    <div>
                        <p class="font-bold">CAUTION: Your Vote is Valuable!</p>
                        <p class="text-sm">Once submitted, you cannot change your selected candidate.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Heading -->
        <h1 class="text-3xl md:text-4xl font-bold text-center text-gray-800 mb-10" data-aos="fade-in">
            <span class="bg-clip-text text-transparent bg-gradient-to-r from-blue-600 to-indigo-600">
                <?php echo $selection_made ? 'Confirm Your Selection' : 'Select Your Candidate'; ?>
            </span>
        </h1>

        <?php if ($selection_made): ?>
        <!-- Display only the selected candidate with confirmation -->
        <div class="mb-8" data-aos="fade-up">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded-md shadow-sm" role="alert">
                 <div class="flex items-center">
                    <div class="py-1"><i class="fas fa-check-circle text-2xl text-green-500 mr-3"></i></div>
                    <div>
                        <p class="font-bold">Candidate Selected</p>
                        <p class="text-sm">You have selected the candidate below. Please review and confirm your vote.</p>
                         <?php if(isset($_GET['reset'])): ?>
                         <p class="text-sm mt-1"><a href="voting.php" class="text-blue-600 hover:underline">Or click here to choose a different candidate.</a></p>
                         <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>

        <form method="post" action="voting.php" class="mb-12">
            <div class="max-w-2xl mx-auto"> 
                <?php
                // Ensure $candidates result pointer is reset if needed (though likely not needed here as it should only have one row)
                 if ($candidates instanceof mysqli_result) $candidates->data_seek(0);

                while ($row = $candidates->fetch_assoc()):
                    $image_path = getImagePath($row['image_path']);
                    $image_class = ''; // Start with no extra classes for the image itself
                    if (!isValidImage($image_path) && $image_path === DEFAULT_IMAGE) {
                         $image_class = 'image-error'; // Add error class only if default is used due to an issue
                    } elseif ($image_path === DEFAULT_IMAGE) {
                        // If it's the default image but no error occurred (e.g., path was empty), maybe don't style as error
                    }
                ?>
                <div class="relative" data-aos="zoom-in" data-aos-duration="800">
                   
                    <div class="selected-candidate border-2 border-green-500 rounded-xl bg-green-50 shadow-lg p-6 flex flex-col sm:flex-row items-center gap-6">
                        <div class="relative flex-shrink-0"> 
                            <img src="<?= htmlspecialchars($image_path) ?>"
                                 alt="<?= htmlspecialchars($row['name']) ?>'s profile picture"
                                 class="w-24 h-24 rounded-full object-cover border-4 border-white shadow-lg <?= $image_class ?>"
                                 onerror="this.onerror=null; this.src='<?= DEFAULT_IMAGE ?>'; this.classList.add('image-error'); console.error('Error loading image:', this.src);"
                                 loading="lazy">
                             
                            <div class="absolute -bottom-2 -right-2 w-8 h-8 bg-green-500 rounded-full flex items-center justify-center border-2 border-white shadow">
                                <i class="fas fa-check text-white text-sm"></i>
                            </div>
                        </div>
                        <div class="text-center sm:text-left">
                            <h3 class="font-bold text-xl text-gray-800"><?= htmlspecialchars($row['name']) ?></h3>
                            <span class="inline-block px-3 py-1 bg-blue-100 text-blue-800 rounded-full text-sm font-semibold mt-2 shadow-sm">
                                <?= htmlspecialchars($row['politic_name']) ?>
                            </span>
                        </div>
                    </div>
                    
                </div>
                <?php endwhile; ?>
            </div>

            <!-- Submit Button for Final Confirmation -->
            <div class="mt-10 text-center flex justify-center items-center gap-4" data-aos="zoom-in" data-aos-duration="1000">
                 <button type="submit" name="submit_vote" class="px-8 py-4 bg-gradient-to-r from-green-500 to-green-600 text-white font-bold rounded-lg text-lg sm:text-xl shadow-lg hover:shadow-xl transform transition hover:-translate-y-1 focus:outline-none focus:ring-4 focus:ring-green-300">
                    <i class="fas fa-vote-yea mr-2"></i> Confirm Your Vote
                </button>
                 
                 <a href="voting.php?reset=1" class="px-6 py-4 bg-gray-200 text-gray-700 font-semibold rounded-lg text-lg sm:text-xl shadow hover:bg-gray-300 transition focus:outline-none focus:ring-2 focus:ring-gray-400">
                    <i class="fas fa-arrow-left mr-2"></i> Change Selection
                 </a>
            </div>
        </form>

        <?php else: ?>
        <!-- Display all candidates for initial selection -->
        <form method="post" action="voting.php" class="mb-12">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <?php
                $delay = 100;
                 // Ensure $candidates result pointer is reset if needed
                 if ($candidates instanceof mysqli_result) $candidates->data_seek(0);

                while ($row = $candidates->fetch_assoc()):
                    $image_path = getImagePath($row['image_path']);
                    // Determine image class based on validation and whether it's the default
                    $image_class = 'image-loading'; // Assume loading initially
                    $is_error = false;
                    if (!isValidImage($image_path) && $image_path === DEFAULT_IMAGE) {
                        $image_class .= ' image-error'; // Add error class if default is used due to an issue
                        $is_error = true;
                    }
                    $delay += 100;
                ?>
                <div class="relative" data-aos="fade-up" data-aos-duration="600" data-aos-delay="<?php echo $delay; ?>">
                  
                    <input type="radio" name="candidate_id" id="candidate_<?= $row['id'] ?>" value="<?= $row['id'] ?>" class="hidden peer" required>

                    
                    <label for="candidate_<?= $row['id'] ?>"
                           class="cursor-pointer block rounded-xl transition duration-300 ease-in-out
                                  peer-checked:ring-4 peer-checked:ring-offset-1 peer-checked:ring-blue-400  
                                  peer-checked:[&>div]:border-blue-500                         
                                  peer-checked:[&>div_.checkmark]:bg-blue-500               
                                  peer-checked:[&>div_.checkmark_i]:opacity-100             
                                  ">
                      
                        <div class="candidate-card border-2 border-gray-200 rounded-xl bg-white shadow-md p-6 flex flex-col sm:flex-row items-center gap-6 hover:border-blue-300 hover:shadow-lg transition duration-300 ease-in-out"> 
                            <div class="relative flex-shrink-0"> 
                                <img src="<?= htmlspecialchars($image_path) ?>"
                                     alt="<?= htmlspecialchars($row['name']) ?>'s profile picture"
                                     class="w-24 h-24 rounded-full object-cover border-4 border-white shadow-lg <?= $image_class ?>"
                                     onerror="this.onerror=null; this.src='<?= DEFAULT_IMAGE ?>'; this.classList.add('image-error'); this.classList.remove('image-loading'); console.error('Error loading image:', this.src);"
                                     onload="this.classList.remove('image-loading');" 
                                     loading="lazy">
                                 <?php if ($is_error): ?>
                                 
                                 <div class="absolute -top-1 -right-1 w-6 h-6 bg-red-500 rounded-full flex items-center justify-center border-2 border-white shadow" title="Image loading error">
                                     <i class="fas fa-exclamation-triangle text-white text-xs"></i>
                                 </div>
                                <?php endif; ?>
                                
                                <div class="absolute -bottom-2 -right-2 w-8 h-8 bg-white rounded-full border-2 border-gray-300 flex items-center justify-center transition-colors duration-300 checkmark">
                                    <i class="fas fa-check text-white text-sm opacity-0 transition-opacity duration-300 checkmark_i"></i>
                                </div>
                            </div>
                            <div class="text-center sm:text-left"> 
                                <h3 class="font-bold text-xl text-gray-800"><?= htmlspecialchars($row['name']) ?></h3>
                                <span class="inline-block px-3 py-1 bg-blue-100 text-blue-800 rounded-full text-sm font-semibold mt-2 shadow-sm">
                                    <?= htmlspecialchars($row['politic_name']) ?>
                                </span>
                            </div>
                        </div>
                    </label>
                  
                </div>
                <?php endwhile; ?>
            </div>

            <!-- Submit Button for Initial Selection -->
            <div class="mt-10 text-center" data-aos="zoom-in" data-aos-duration="1000" data-aos-delay="300"> 
                <button type="submit" name="select_candidate" class="px-8 py-4 bg-gradient-to-r from-blue-500 to-indigo-600 text-white font-bold rounded-lg text-lg sm:text-xl shadow-lg hover:shadow-xl transform transition hover:-translate-y-1 focus:outline-none focus:ring-4 focus:ring-blue-300 disabled:opacity-50 disabled:cursor-not-allowed" id="select-button" disabled> 
                    <i class="fas fa-check-double mr-2"></i> Select Candidate
                </button>
                 <p id="select-warning" class="text-red-600 text-sm mt-2 hidden">Please select a candidate first.</p>
            </div>
        </form>
        <?php endif; ?>
    </div>

    <?php include 'footer.php'; // Ensure footer.php exists and is correctly included ?>

    <!-- Scripts (Unchanged as requested) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
    <script>
        // Timer and Clock Script (Unchanged)
        let timeLeft = 60; // 60 seconds
        let countdownInterval;

        function updateTimerDisplay() {
            let minutes = Math.floor(timeLeft / 60);
            let seconds = timeLeft % 60;
            const timerElement = document.getElementById("timer");
            if (timerElement) {
                 timerElement.textContent = `${minutes}:${seconds < 10 ? "0" : ""}${seconds}`;
                 // Add visual cue when time is low
                 if (timeLeft <= 10) {
                     timerElement.classList.add('text-red-400', 'animate-pulse');
                 } else {
                     timerElement.classList.remove('text-red-400', 'animate-pulse');
                 }
             }
        }

        function startCountdown() {
             updateTimerDisplay(); // Initial display
            countdownInterval = setInterval(() => {
                if (timeLeft > 0) {
                    timeLeft--;
                    updateTimerDisplay();
                } else {
                    clearInterval(countdownInterval);
                    // Redirect to a timeout page or main page
                    window.location.href = "timeout.php"; // Example: Redirect to a specific timeout page
                }
            }, 1000);
        }

        function resetTimerOnActivity() {
            // This function resets the timer to the full duration on activity
            // Be cautious with this, as it might keep the session alive indefinitely
            // If you want a strict timeout, don't reset it fully, or just use the initial load timer.
            // For now, let's keep it simple and not reset on activity unless specifically required.
            // To implement reset:
            // clearInterval(countdownInterval);
            // timeLeft = 60; // Reset to full time
            // startCountdown();
        }

        // // Example listeners (Uncomment IF you want activity to reset the timer)
        // document.addEventListener("mousemove", resetTimerOnActivity, { passive: true });
        // document.addEventListener("keydown", resetTimerOnActivity, { passive: true });
        // document.addEventListener("click", resetTimerOnActivity, { passive: true });
        // document.addEventListener("scroll", resetTimerOnActivity, { passive: true });

        // Start the countdown when the page loads
        startCountdown();


        // Initialize AOS
        AOS.init({
            once: true, // Only animate elements once
            duration: 600 // Default duration
        });

        // Live Clock (Unchanged)
        function updateTime() {
            const now = new Date();
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            const seconds = String(now.getSeconds()).padStart(2, '0');

            const hoursElement = document.getElementById('hours');
            const minutesElement = document.getElementById('minutes');
            const secondsElement = document.getElementById('seconds');

             // Only update if the element exists
             if (hoursElement && hoursElement.textContent !== hours) {
                hoursElement.classList.add('flip');
                setTimeout(() => { hoursElement.textContent = hours; hoursElement.classList.remove('flip'); }, 300);
            }
            if (minutesElement && minutesElement.textContent !== minutes) {
                minutesElement.classList.add('flip');
                setTimeout(() => { minutesElement.textContent = minutes; minutesElement.classList.remove('flip'); }, 300);
            }
            if (secondsElement && secondsElement.textContent !== seconds) {
                // Update seconds more frequently without flip for smoother feel, or keep flip
                // secondsElement.textContent = seconds; // Smoother update
                 secondsElement.classList.add('flip'); // Keep flip animation
                 setTimeout(() => { secondsElement.textContent = seconds; secondsElement.classList.remove('flip'); }, 300);
            }
        }

        // Update time immediately and then every second
        updateTime();
        const clockInterval = setInterval(updateTime, 1000);

        // Enhanced image loading handling (Unchanged logic, adapted selectors if needed)
        document.addEventListener('DOMContentLoaded', function() {
            const images = document.querySelectorAll('.candidate-card img, .selected-candidate img');
            images.forEach(img => {
                 // Check if image is already loaded (might happen from cache)
                if (img.complete && img.naturalHeight !== 0) {
                    img.classList.remove('image-loading');
                } else if (img.complete && img.naturalHeight === 0) {
                     // Complete but no height usually means error
                     img.onerror(); // Trigger the onerror handler manually
                 } else {
                    // Add listeners for load and error events
                    img.addEventListener('load', function() {
                        this.classList.remove('image-loading');
                        // Optional: Check naturalWidth/Height for robustness
                         if (this.naturalWidth === 0 || this.naturalHeight === 0) {
                             this.onerror(); // Treat 0-dimension load as error
                         }
                    });
                    // The onerror attribute handles error state directly in HTML now
                }
            });


            // Radio button handling for enabling submit button (Pure JS for enabling button)
            const radioButtons = document.querySelectorAll('input[type="radio"][name="candidate_id"]');
            const selectButton = document.getElementById('select-button');
            const selectWarning = document.getElementById('select-warning');

            if (selectButton) { // Only run if the button exists (i.e., not in confirmation view)
                radioButtons.forEach(radio => {
                    radio.addEventListener('change', function() {
                        if (this.checked) {
                            selectButton.disabled = false; // Enable the button
                            selectButton.classList.remove('disabled:opacity-50', 'disabled:cursor-not-allowed');
                            if(selectWarning) selectWarning.classList.add('hidden'); // Hide warning
                        }
                    });
                });

                 // Optional: Prevent form submission if button is disabled (extra safety)
                 const candidateForm = selectButton.closest('form');
                 if (candidateForm) {
                     candidateForm.addEventListener('submit', function(event) {
                         if (selectButton.disabled) {
                             event.preventDefault(); // Stop submission
                             if(selectWarning) selectWarning.classList.remove('hidden'); // Show warning
                             console.warn('Submit blocked: No candidate selected.');
                         }
                     });
                 }
            }

             // Cleanup intervals on page unload to prevent memory leaks
             window.addEventListener('beforeunload', () => {
                 clearInterval(countdownInterval);
                 clearInterval(clockInterval);
             });

        });

        <?php if ($selection_made): ?>
        // Animation for selected candidate card (Unchanged)
        document.addEventListener('DOMContentLoaded', function() {
            const selectedCard = document.querySelector('.selected-candidate');
            if (selectedCard) {
                 // Apply initial pulse effect, then rely on the CSS animation for continuous pulse
                selectedCard.classList.add('animate-pulse');
                 setTimeout(() => {
                     // Optionally remove the initial Tailwind pulse if the CSS animation is preferred long-term
                     // selectedCard.classList.remove('animate-pulse');
                 }, 2000); // Duration of initial pulse
            }
        });
        <?php endif; ?>

    </script>
</body>
</html>