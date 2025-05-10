<?php
// Database connection parameters
$servername = "localhost";
$username = "root";  // Replace with your database username
$password = "";      // Replace with your database password
$dbname = "online_voting_system";  // Updated database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    // In a production environment, log the error instead of dying
    error_log("Database Connection failed: " . $conn->connect_error);
    // Display a user-friendly message or use default values
    // For this example, we'll proceed with default values if connection fails.
    $conn = null; // Set conn to null to indicate failure
    // die("Connection failed: " . $conn->connect_error); // Avoid dying on landing page
}

// Function to get all votes (Example: Not used directly in landing page display)
function getAllVotes($conn) {
    // Check if connection is valid
    if (!$conn) return []; // Return empty if no connection

    $votes = array();
    // Added voter_id_string which was missing in the original function signature
    $sql = "SELECT vote_id, candidate_id, voter_time, voter_id_string FROM votes ORDER BY voter_time DESC";
    $result = $conn->query($sql);

    if ($result && $result->num_rows > 0) { // Added check for successful query
        while($row = $result->fetch_assoc()) {
            $votes[] = $row;
        }
    } elseif ($result === false) {
        error_log("Error in getAllVotes query: " . $conn->error);
    }

    return $votes;
}

// Function to get vote count
function getVoteCount($conn) {
    // Check if connection is valid
    if (!$conn) return 0;

    $sql = "SELECT COUNT(*) as total FROM votes";
    $result = $conn->query($sql);
    if ($result) { // Check if query was successful
        $row = $result->fetch_assoc();
        return $row['total'] ?? 0; // Return 0 if total is null
    } else {
        error_log("Error in getVoteCount query: " . $conn->error);
        return 0; // Return 0 if query failed
    }
}

// Function to get votes by candidate (Example: Not used directly in landing page display)
function getVotesByCandidate($conn) {
     // Check if connection is valid
    if (!$conn) return [];

    $candidates = array();
    $sql = "SELECT candidate_id, COUNT(*) as vote_count FROM votes GROUP BY candidate_id";
    $result = $conn->query($sql);

    if ($result && $result->num_rows > 0) { // Added check for successful query
        while($row = $result->fetch_assoc()) {
            // Ensure candidate_id exists before assigning
            if (isset($row['candidate_id'])) {
                 $candidates[$row['candidate_id']] = $row['vote_count'] ?? 0;
            }
        }
    } elseif ($result === false) {
        error_log("Error in getVotesByCandidate query: " . $conn->error);
    }

    return $candidates;
}

// Function to get recent votes for live feed
function getRecentVotes($conn, $limit = 5) { // Default limit set to 5
    // Check if connection is valid
    if (!$conn) return [];

    $votes = array();
    // Fixed SQL to handle potential NULLs gracefully and ensure correct JOIN
    $sql = "SELECT v.vote_id, v.candidate_id, v.voter_time, v.voter_id_string,
                   COALESCE(c.name, 'Unknown Candidate') as candidate_name,
                   COALESCE(c.politic_name, 'No Party') as politic_name
            FROM votes v
            LEFT JOIN candidates c ON v.candidate_id = c.id
            ORDER BY v.voter_time DESC
            LIMIT ?";

    $stmt = $conn->prepare($sql);
    if ($stmt) { // Check if prepare was successful
        $stmt->bind_param("i", $limit);
        if ($stmt->execute()) { // Check if execute was successful
            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                    // Ensure voter_time is a valid format or set a default
                     if (isset($row['voter_time'])) {
                        // Attempt to create a DateTime object to validate
                        try {
                            new DateTime($row['voter_time']);
                        } catch (Exception $e) {
                            // Log invalid date format, potentially set to null or current time
                            error_log("Invalid date format for vote_id {$row['vote_id']}: " . $row['voter_time']);
                            $row['voter_time'] = null; // Or date('Y-m-d H:i:s');
                        }
                     } else {
                         $row['voter_time'] = null; // Or handle as needed
                     }
                    $votes[] = $row;
                }
            }
        } else {
             error_log("Error executing getRecentVotes statement: " . $stmt->error); // Log error
        }
        $stmt->close();
    } else {
        error_log("Error preparing getRecentVotes statement: " . $conn->error); // Log error
    }
    return $votes;
}


// Function to get all candidates (Example: Not used directly in landing page display)
function getAllCandidates($conn) {
    // Check if connection is valid
    if (!$conn) return [];

    $candidates = array();
    $sql = "SELECT id, name, place, politic_name, image_path FROM candidates ORDER BY id";
    $result = $conn->query($sql);

    if ($result && $result->num_rows > 0) { // Added check for successful query
        while($row = $result->fetch_assoc()) {
            $candidates[] = $row;
        }
    } elseif ($result === false) {
        error_log("Error in getAllCandidates query: " . $conn->error);
    }

    return $candidates;
}

// Function to get total number of registered voters
function getRegisteredVotersCount($conn) {
    // Check if connection is valid
    if (!$conn) return 0;

    // Check if 'voters' table exists before querying
    $tableCheckSql = "SHOW TABLES LIKE 'voters'";
    $tableCheckResult = $conn->query($tableCheckSql);
    if ($tableCheckResult && $tableCheckResult->num_rows > 0) {
        $sql = "SELECT COUNT(*) as total FROM voters"; // Assumes a 'voters' table exists
        $result = $conn->query($sql);
         if ($result) { // Check if query was successful
            $row = $result->fetch_assoc();
            return $row['total'] ?? 0; // Return 0 if total is null
        } else {
            error_log("Error in getRegisteredVotersCount query: " . $conn->error);
            return 0; // Return 0 if query failed
        }
    } else {
        error_log("Error: 'voters' table not found.");
        return 0; // Return 0 if table doesn't exist
    }
}

// Note: addVote function is not typically called from the landing page itself,
// but kept here for completeness if this file were reused.
// CSRF protection requires session_start() *before* any output.
// Moved session_start() to the top if needed, or manage sessions appropriately.
/*
function addVote($conn, $candidate_id, $voter_id_string, $csrf_token = null) {
    if (!$conn) return false; // Check connection
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }
    if ($csrf_token && (!isset($_SESSION['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $csrf_token))) { // Use hash_equals for timing attack resistance
        error_log("CSRF token mismatch"); // Log CSRF failure
        return false; // Invalid CSRF token
    }
    $sql = "INSERT INTO votes (candidate_id, voter_id_string) VALUES (?, ?)";
    $stmt = $conn->prepare($sql);
     if ($stmt) { // Check prepare success
        $stmt->bind_param("is", $candidate_id, $voter_id_string);

        if ($stmt->execute()) {
            $new_vote_id = $conn->insert_id;
            $stmt->close();
            // Optionally regenerate CSRF token after successful action
            // $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
            return $new_vote_id;
        } else {
            error_log("Error executing addVote statement: " . $stmt->error); // Log error
            $stmt->close();
            return false;
        }
    } else {
         error_log("Error preparing addVote statement: " . $conn->error); // Log error
        return false;
    }
}
*/

// --- Data Fetching ---
// Set default values
$totalVotes = 0;
$registeredVoters = 0;
$recentVotes = [];
$turnoutPercentage = 0;

// Fetch data only if connection is successful
if ($conn) {
    try {
        $totalVotes = getVoteCount($conn);
        $registeredVoters = getRegisteredVotersCount($conn); // Assumes 'voters' table exists
        $recentVotes = getRecentVotes($conn, 5); // Fetch 5 recent votes

        // Calculate voter turnout percentage safely
        $turnoutPercentage = ($registeredVoters > 0) ? round(($totalVotes / $registeredVoters) * 100) : 0;

        // Data not directly used on landing page, but fetched for potential use
        // $allVotes = getAllVotes($conn);
        // $candidateVotes = getVotesByCandidate($conn);
        // $allCandidates = getAllCandidates($conn);

    } catch (Exception $e) {
        // Log error and ensure default values are used
        error_log("Database Error during data fetch: " . $e->getMessage());
        $totalVotes = 0; // Redundant due to defaults, but safe
        $registeredVoters = 0;
        $recentVotes = [];
        $turnoutPercentage = 0;
        // Handle the error gracefully, maybe display a message to the user
        // echo "<p class='text-center text-red-500'>An error occurred while fetching voting data. Some information may be unavailable.</p>";
    } finally {
        // Close the connection
        $conn->close();
    }
} else {
    // Optionally log that the connection failed earlier and defaults are being used
    error_log("Proceeding with default values due to database connection failure.");
     // Optionally display a message if critical data is missing
    // echo "<p class='text-center text-yellow-500'>Could not connect to the database. Displaying default information.</p>";
}


// Generate CSRF token if needed for forms (though this page doesn't submit votes)
/*
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
if (empty($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}
$csrf_token = $_SESSION['csrf_token'];
*/
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Online Voting System - Secure & Modern Elections</title>
    <meta name="description" content="Participate in elections securely and conveniently with our advanced online voting platform. Check live results, learn about candidates, and cast your vote.">
    <!-- Favicon -->
    <link rel="icon" href="/favicon.ico" type="image/x-icon">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <!-- Tailwind CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" rel="stylesheet"/>
    <!-- AOS -->
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
      :root {
        --primary-color: #4f46e5; /* Indigo 600 */
        --primary-dark: #4338ca;  /* Indigo 700 */
        --accent-color: #f59e0b;  /* Amber 500 */
        --neutral-light: #f9fafb; /* Gray 50 */
        --neutral-dark: #1f2937;  /* Gray 800 */
        --success-color: #10b981; /* Emerald 500 */
        --vote-confirmed: #22c55e; /* Green 500 */
        --vote-processing: #facc15; /* Yellow 400 */
        --vote-error: #ef4444;    /* Red 500 */
      }

      html {
         scroll-behavior: smooth;
      }

      body {
        font-family: 'Inter', sans-serif;
        background-color: var(--neutral-light);
        color: var(--neutral-dark);
        overflow-x: hidden; /* Prevent horizontal scroll */
      }

      /* Header Styles */
      .header-wrapper {
        position: relative; /* Needed for absolute positioning of canvas */
        min-height: 100vh; /* Full viewport height */
        display: flex;
        align-items: center;
        justify-content: center; /* Center content vertically and horizontally */
        padding-top: 80px; /* Space for potential fixed navbar */
        overflow: hidden; /* Hide overflowing particles */
        background-size: 400% 400%; /* For gradient animation */
      }

      /* Parallax Background */
      .parallax-bg {
        position: absolute; /* Changed from fixed to absolute within header */
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: url('https://images.unsplash.com/photo-1590614880471-5b430a4cca4d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80') no-repeat center center/cover; /* More relevant image */
        opacity: 0.15; /* Slightly increased opacity */
        z-index: 0;
        /* Removed transform for simplicity with absolute positioning */
      }

      /* Particle Canvas */
      #particle-canvas {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 1; /* Above parallax, below content */
      }

      /* Navbar Placeholder (if needed) */
      /* header { ... } */

      /* Hero Section */
      .hero-content {
        position: relative;
        z-index: 5; /* Above particles and parallax */
        text-align: center;
        color: white;
        max-width: 1200px;
        margin: 0 auto;
        padding: 2rem 1rem; /* Added padding */
      }

      .hero-content h1 {
        font-size: clamp(2.5rem, 6vw, 4rem); /* Responsive font size */
        font-weight: 700;
        line-height: 1.2;
        text-shadow: 0 3px 6px rgba(0, 0, 0, 0.4);
      }

      .hero-content .typed-container {
        font-size: clamp(1rem, 2.5vw, 1.25rem); /* Responsive font size */
        min-height: 3em; /* Prevent layout shift */
        max-width: 700px;
        margin: 1.5rem auto;
        opacity: 0.9;
      }

      /* Vote Counter */
      .vote-counter {
        font-size: clamp(1.5rem, 4vw, 2rem); /* Responsive font size */
        font-weight: 600;
        color: var(--success-color);
        margin: 2rem 0;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
      }
      #vote-count {
         display: inline-block;
         min-width: 40px; /* Prevent jumpiness when counting */
      }

      /* Advanced Button */
      .hero-btn {
        position: relative;
        overflow: hidden;
        /* SLIGHTLY LARGER BUTTON */
        padding: 0.9rem 2.2rem; /* Adjusted padding */
        font-weight: 600;
        font-size: 1.05rem; /* Slightly larger font */
        letter-spacing: 0.05em;
        text-transform: uppercase;
        border-radius: 9999px;
        background: var(--primary-color);
        color: white;
        border: none; /* Remove default border */
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        transition: transform 0.3s ease, box-shadow 0.3s ease, background-color 0.3s ease;
        cursor: pointer;
      }

      .hero-btn:hover {
        background: var(--primary-dark);
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(79, 70, 229, 0.4); /* Colorized shadow */
      }

      .hero-btn:focus-visible { /* Use focus-visible for accessibility */
        outline: 3px solid var(--accent-color);
        outline-offset: 2px;
      }

      .hero-btn:active {
        transform: scale(0.95);
      }

      /* Pulse Animation */
      .pulse {
        animation: pulse 2.5s infinite ease-in-out;
      }
      @keyframes pulse {
        0%, 100% { transform: scale(1); box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2); }
        50% { transform: scale(1.05); box-shadow: 0 8px 25px rgba(79, 70, 229, 0.4); }
      }

      /* Floating Animation */
      .float {
        animation: float 5s ease-in-out infinite;
      }
      @keyframes float {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-12px); }
      }

      /* Gradient Shift */
      .gradient-shift {
        background: linear-gradient(-45deg, #4f46e5, #7c3aed, #a855f7, #ec4899); /* Adjusted gradient */
        background-size: 400% 400%;
        animation: gradientShift 18s ease infinite;
      }
      @keyframes gradientShift {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
      }

      /* Lottie Animation */
      #lottie-animation-container {
        width: 100%;
        /* SLIGHTLY LARGER LOTTIE */
        max-width: 400px; /* Increased size */
        height: 320px; /* Increased size */
        margin: 1.5rem auto; /* Keep margin or adjust if needed */
        cursor: pointer;
        z-index: 10;
        transition: transform 0.3s ease;
      }
       #lottie-animation-container:hover {
          transform: scale(1.05);
       }


      /* Main Content Area */
       main {
          position: relative; /* Ensure content is above potential fixed elements */
          z-index: 10;
          background-color: var(--neutral-light); /* Background for content below header */
          padding-top: 4rem;
          padding-bottom: 4rem;
       }

      /* Footer Styles */
      footer {
        background: var(--neutral-dark);
        color: var(--neutral-light); /* Lighter text on dark */
        padding: 4rem 1rem; /* Added horizontal padding */
        position: relative;
        z-index: 5; /* Above potential lower elements */
      }

      .team-card {
        background: rgba(255, 255, 255, 0.05); /* Slightly less visible */
        border-radius: 1rem;
        padding: 1.5rem;
        transition: transform 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275), box-shadow 0.4s ease; /* Bouncier transition */
        position: relative;
        backdrop-filter: blur(3px); /* Subtle blur */
        transform-style: preserve-3d; /* Needed for perspective */
        border: 1px solid rgba(255, 255, 255, 0.1);
      }

      .team-card:hover {
        transform: translateY(-10px) rotateX(5deg) rotateY(-3deg) scale(1.03); /* 3D hover effect */
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
      }

      .team-head { /* Specific style for the lead */
        border: 2px solid var(--accent-color);
        background: linear-gradient(135deg, var(--primary-dark), var(--primary-color));
        box-shadow: 0 8px 20px rgba(79, 70, 229, 0.3);
      }
       .team-head:hover {
         box-shadow: 0 18px 40px rgba(79, 70, 229, 0.5);
          transform: translateY(-12px) rotateX(7deg) rotateY(-4deg) scale(1.05);
       }

      .social-icons a {
        margin: 0 0.5rem;
        color: var(--neutral-light);
        transition: transform 0.3s ease, color 0.3s ease;
        font-size: 1.2rem; /* Slightly larger icons */
      }

      .social-icons a:hover {
        transform: scale(1.3) rotate(10deg);
        color: var(--accent-color);
      }

      /* Vote Animation */
      .vote-pop {
        animation: votePop 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55); /* Spring effect */
      }
      @keyframes votePop {
        0% { transform: scale(0.5); opacity: 0; }
        70% { transform: scale(1.1); opacity: 1; }
        100% { transform: scale(1); opacity: 1; }
      }

      /* Ballot Animation */
      .ballot-box {
        position: relative;
        /* SLIGHTLY LARGER BALLOT BOX */
        width: 180px; /* Increased size */
        height: 120px; /* Increased size */
        margin: 2rem auto; /* Keep margin or adjust */
        background: linear-gradient(145deg, #e8e8e8, #fdfdfd); /* Lighter */
        border-radius: 8px;
        box-shadow: inset 0 2px 4px rgba(0,0,0,0.1), 0 8px 15px rgba(0, 0, 0, 0.15);
        overflow: hidden;
        z-index: 10;
      }

      .ballot-slot {
        position: absolute;
        top: 10px; /* Keep distance from top */
        left: 50%;
        transform: translateX(-50%);
        /* WIDER SLOT FOR BIGGER BOX */
        width: 70px; /* Increased width */
        height: 6px; /* Slightly thicker */
        background: #555;
        border-radius: 3px;
        box-shadow: inset 0 1px 2px rgba(0,0,0,0.3);
      }

      .ballot-paper {
        position: absolute;
        /* ADJUSTED PAPER SIZE & POSITION */
        top: -85px; /* Start higher based on new height */
        left: 50%;
        width: 60px; /* Wider paper */
        height: 85px; /* Longer paper */
        background: white;
        border: 1px solid #ccc;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        display: flex;
        align-items: center;
        justify-content: center;
        transform-origin: top center; /* Rotate from top */
      }

      .ballot-checkmark {
        color: var(--success-color);
        /* LARGER CHECKMARK */
        font-size: 30px; /* Increased size */
        opacity: 0;
      }

      .ballot-drop {
        /* ADJUSTED KEYFRAMES FOR LARGER SIZE */
        animation: ballotDrop 1.8s cubic-bezier(0.6, -0.28, 0.735, 0.045) forwards; /* Ease-in with overshoot */
      }
      @keyframes ballotDrop {
         0% { top: -85px; transform: translateX(-50%) rotate(0deg); opacity: 1; } /* Start higher */
         40% { top: 18px; transform: translateX(-50%) rotate(-8deg); } /* Insert point below slot */
         70% { top: 14px; transform: translateX(-50%) rotate(5deg); } /* Go slightly past */
         100% { top: 80px; transform: translateX(-50%) rotate(0deg); opacity: 0; } /* Fall inside further */
      }

      .checkmark-pop {
        animation: checkPop 0.5s ease-out 1.2s forwards; /* Delayed pop */
      }
      @keyframes checkPop {
        0% { transform: scale(0); opacity: 0; }
        70% { transform: scale(1.3); opacity: 1; }
        100% { transform: scale(1); opacity: 1; }
      }

      /* Vote Progress Bar */
      .vote-progress-container {
        width: 100%;
        max-width: 400px; /* Smaller max width */
        margin: 1.5rem auto 2rem auto; /* Adjusted margin */
        background: rgba(255, 255, 255, 0.1); /* Darker BG on light header */
        border-radius: 9999px;
        overflow: hidden;
        height: 12px; /* Slightly thicker */
        position: relative;
        z-index: 10;
        border: 1px solid rgba(255, 255, 255, 0.2);
        box-shadow: inset 0 1px 3px rgba(0,0,0,0.2);
      }

      .vote-progress-bar {
        height: 100%;
        background: linear-gradient(90deg, var(--success-color), #34d399); /* Gradient bar */
        width: 0; /* Initial width */
        transition: width 1.8s cubic-bezier(0.25, 1, 0.5, 1); /* Smoother transition */
        border-radius: 9999px;
      }

      /* Vote Stats Cards */
      .vote-stats-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 1.5rem; /* Increased gap */
        margin: 2.5rem 0;
        z-index: 10;
      }

      .vote-stat-card {
        background: rgba(0, 0, 0, 0.2); /* Darker translucent card */
        backdrop-filter: blur(8px);
        border-radius: 1rem;
        padding: 1.5rem;
        width: calc(33.333% - 1.5rem);
        min-width: 180px; /* Adjusted min-width */
        text-align: center;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        position: relative;
        z-index: 10;
        border: 1px solid rgba(255, 255, 255, 0.1);
        color: white; /* Text color white */
      }

      .vote-stat-card:hover {
        transform: translateY(-8px) scale(1.02);
        box-shadow: 0 12px 30px rgba(0, 0, 0, 0.2);
      }

      .vote-stat-icon {
         font-size: 1.8rem; /* Adjusted icon size */
         margin-bottom: 0.5rem;
         color: var(--accent-color); /* Use accent color for icons */
      }

      .vote-stat-number {
        font-size: clamp(1.8rem, 5vw, 2.5rem); /* Responsive */
        font-weight: 700;
        margin: 0.5rem 0;
        line-height: 1.1;
        color: white; /* Ensure number is white */
        /* Removed gradient text for better contrast on dark card */
      }
       .vote-stat-label {
          font-size: 0.9rem;
          color: rgba(255, 255, 255, 0.8); /* Lighter label text */
       }

      /* Vote Success Animation */
      .vote-success-container {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.85); /* Darker overlay */
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 1200;
        opacity: 0;
        pointer-events: none;
        transition: opacity 0.4s ease;
        backdrop-filter: blur(5px); /* Blur background */
      }

      .vote-success-content {
        background: white;
        border-radius: 1rem;
        padding: 2.5rem; /* More padding */
        text-align: center;
        max-width: 450px; /* Adjusted max-width */
        width: 90%;
        transform: scale(0.7) translateY(20px); /* Start smaller and lower */
        transition: transform 0.4s cubic-bezier(0.34, 1.56, 0.64, 1), opacity 0.4s ease; /* Spring effect */
        box-shadow: 0 10px 30px rgba(0,0,0,0.2);
      }

      .vote-success-container.vote-success-show { /* Renamed class for clarity */
        opacity: 1;
        pointer-events: auto;
      }

      .vote-success-container.vote-success-show .vote-success-content {
        transform: scale(1) translateY(0);
        opacity: 1;
      }

      .checkmark-circle {
        /* SLIGHTLY LARGER CHECKMARK CIRCLE */
        width: 140px; /* Increased size */
        height: 140px; /* Increased size */
        position: relative;
        margin: 0 auto 1.5rem auto; /* Add bottom margin */
      }

      .checkmark-circle-fill {
        position: absolute;
        width: 100%;
        height: 100%;
        border-radius: 50%;
        background: var(--success-color);
        opacity: 0;
        transform: scale(0);
      }

      .checkmark-circle-check {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%) scale(0);
        color: white;
        /* LARGER CHECK ICON INSIDE */
        font-size: 70px; /* Increased size */
        opacity: 0;
      }

      /* Animations applied via JS */
      @keyframes circleFill {
        0% { transform: scale(0); opacity: 0; }
        100% { transform: scale(1); opacity: 1; }
      }
      @keyframes circleCheck {
        0% { transform: translate(-50%, -50%) scale(0) rotate(-45deg); opacity: 0; } /* Add rotation */
        70% { transform: translate(-50%, -50%) scale(1.2) rotate(0deg); opacity: 1; }
        100% { transform: translate(-50%, -50%) scale(1) rotate(0deg); opacity: 1; }
      }
      .circle-fill-animate { animation: circleFill 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55) forwards; }
      .circle-check-animate { animation: circleCheck 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55) 0.3s forwards; } /* Delayed checkmark */


      /* Vote button effects */
      .vote-btn-container {
        position: relative;
        display: inline-block; /* Needed for ripple positioning */
        margin: 1.5rem 0 0 0; /* Adjust margin */
        z-index: 10;
      }

      .vote-btn-ripple {
        position: absolute;
        top: 0; left: 0; right: 0; bottom: 0; /* Cover button */
        border-radius: 9999px;
        background: rgba(255, 255, 255, 0.4); /* White ripple */
        transform: scale(0);
        opacity: 1;
        pointer-events: none; /* Allow clicks to pass through */
      }

      .ripple-animate {
        animation: rippleEffect 0.8s ease-out;
      }
      @keyframes rippleEffect {
        to {
          transform: scale(2.5);
          opacity: 0;
        }
      }

      /* Live Vote Feed */
      .live-vote-feed {
        position: fixed;
        bottom: 20px; /* Consistent spacing */
        right: 20px;
        width: 320px; /* Slightly wider */
        max-height: 450px; /* Allow more height */
        overflow-y: auto;
        background: rgba(255, 255, 255, 0.98); /* More opaque */
        border-radius: 12px; /* Smoother radius */
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        padding: 0; /* Remove padding, handle inside */
        z-index: 1100;
        transform: translateX(110%); /* Start further off-screen */
        transition: transform 0.5s cubic-bezier(0.25, 1, 0.5, 1); /* Smooth slide */
        border: 1px solid rgba(0,0,0,0.05);
      }

      .live-vote-feed.show-feed { /* Use specific class */
        transform: translateX(0);
      }

      .feed-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0.75rem 1rem; /* Header padding */
        border-bottom: 1px solid #eee;
        background-color: #f9fafb; /* Header background */
        border-radius: 12px 12px 0 0; /* Match container radius */
        position: sticky; /* Keep header visible */
        top: 0;
        z-index: 1;
      }
       .feed-header h3 {
         font-size: 1rem;
         font-weight: 600;
         color: var(--neutral-dark);
       }
       .feed-header button {
          background: none;
          border: none;
          color: #9ca3af; /* Gray 400 */
          cursor: pointer;
          font-size: 1.1rem;
       }
        .feed-header button:hover {
           color: var(--neutral-dark);
        }

       .feed-content {
          padding: 1rem; /* Padding for the entries */
       }

      .feed-toggle {
        position: fixed; /* Ensure it stays */
        bottom: 30px; /* Raise slightly */
        right: 30px;
        background: var(--primary-color);
        color: white;
        border: none;
        width: 50px; /* Larger */
        height: 50px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        z-index: 1150;
        box-shadow: 0 4px 15px rgba(79, 70, 229, 0.4);
        transition: transform 0.3s ease, background-color 0.3s ease;
      }
       .feed-toggle:hover {
          background: var(--primary-dark);
          transform: scale(1.1) rotate(-15deg);
       }
       .feed-toggle i {
          font-size: 1.2rem;
       }


      .vote-entry {
        padding: 0.8rem;
        border-radius: 8px;
        margin-bottom: 0.75rem; /* Increased margin */
        background: #ffffff; /* White background */
        box-shadow: 0 3px 8px rgba(0, 0, 0, 0.07);
        border: 1px solid #f3f4f6; /* Gray 100 border */
        opacity: 0; /* Start hidden */
        transform: translateY(15px) scale(0.95); /* Start lower and smaller */
        transition: opacity 0.5s ease, transform 0.5s ease;
      }

      .vote-entry.show {
        opacity: 1;
        transform: translateY(0) scale(1);
      }

      .vote-entry .font-semibold { color: var(--primary-dark); }
      .vote-entry .text-sm { color: #4b5563; } /* Gray 600 */
      .vote-entry .text-xs { color: #6b7280; } /* Gray 500 */

      .vote-time {
        font-size: 0.7rem; /* Smaller time */
        color: #9ca3af; /* Gray 400 */
        text-align: right;
        margin-top: 0.25rem;
      }

      /* Voter ID Card Flip Animation */
      .voter-id-card {
        width: 280px; /* Adjusted size */
        height: 170px; /* Adjusted size */
        perspective: 1200px; /* Increased perspective */
        margin: 2.5rem auto;
        max-width: 280px;
        z-index: 10;
      }

      .voter-id-inner {
        position: relative;
        width: 100%;
        height: 100%;
        transition: transform 0.8s cubic-bezier(0.7, 0, 0.3, 1); /* Smoother flip */
        transform-style: preserve-3d;
      }

      .voter-id-card:hover .voter-id-inner {
        transform: rotateY(180deg);
      }

      .voter-id-front, .voter-id-back {
        position: absolute;
        width: 100%;
        height: 100%;
        -webkit-backface-visibility: hidden; /* Safari */
        backface-visibility: hidden;
        border-radius: 12px; /* Match other elements */
        overflow: hidden;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
      }

      .voter-id-front {
        background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
        color: white;
        display: flex;
        flex-direction: column;
        justify-content: space-between; /* Space out elements */
        align-items: center;
        padding: 1rem;
      }
       .voter-id-front h3 { font-size: 1rem; font-weight: bold; }
       .voter-id-front p { font-size: 0.8rem; opacity: 0.8; }


      .voter-id-back {
        background: var(--neutral-light);
        color: var(--neutral-dark);
        transform: rotateY(180deg);
        padding: 1rem;
        display: flex;
        flex-direction: column;
        justify-content: center;
        font-size: 0.85rem; /* Smaller text */
      }
       .voter-id-back h4 { font-size: 0.95rem; font-weight: 600; margin-bottom: 0.3rem; }
       .voter-id-back p { margin-bottom: 0.2rem; line-height: 1.3; }


      .voter-id-photo {
        width: 50px; /* Smaller photo */
        height: 50px;
        background: rgba(255, 255, 255, 0.2); /* Lighter */
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 0.5rem;
         border: 2px solid rgba(255, 255, 255, 0.3);
      }
       .voter-id-photo i { font-size: 1.5rem; opacity: 0.8; }

      .voter-id-barcode {
        width: 90%; /* Wider barcode */
        height: 35px;
        background: repeating-linear-gradient(90deg, #333, #333 2px, #fff 2px, #fff 4px);
        margin-top: 1rem;
        align-self: center; /* Center barcode */
      }

      /* Vote Badge Animation */
      .vote-badge {
        position: relative;
        display: inline-block;
        padding: 0.6rem 1.2rem; /* Slightly larger */
        background: var(--success-color);
        color: white;
        border-radius: 9999px;
        font-weight: 600; /* Bolder */
        font-size: 0.9rem;
        margin: 2rem 0;
        overflow: hidden;
        z-index: 10;
        box-shadow: 0 4px 10px rgba(16, 185, 129, 0.4); /* Colored shadow */
      }

      .vote-badge::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -70%; /* Start further left */
        width: 40%; /* Narrower shine */
        height: 200%;
        background: linear-gradient(to right, rgba(255,255,255,0) 0%, rgba(255,255,255,0.4) 50%, rgba(255,255,255,0) 100%); /* Softer shine */
        transform: skewX(-25deg); /* Angled shine */
        animation: badgeShine 3.5s linear infinite;
      }
      @keyframes badgeShine {
        from { left: -70%; }
        to { left: 130%; } /* Move further right */
      }

      /* Responsive Adjustments */
      @media (max-width: 992px) { /* Adjust breakpoint */
          .vote-stat-card {
            width: calc(50% - 1.5rem); /* Two cards per row on medium */
          }
          .team-card {
              margin-bottom: 1.5rem; /* Add space between rows */
          }
      }

      @media (max-width: 768px) {
        .header-wrapper { min-height: 90vh; } /* Slightly shorter */
        /* SLIGHTLY LARGER MOBILE LOTTIE */
        #lottie-animation-container { max-width: 340px; height: 270px; }
        /* SLIGHTLY LARGER MOBILE BALLOT BOX */
        .ballot-box { width: 150px; height: 100px; }
        .live-vote-feed { width: 280px; }
        #particle-canvas { display: none; } /* Hide particles on smaller devices for performance */
        .team-card { transform-style: flat; } /* Disable 3D hover on mobile */
        .team-card:hover { transform: translateY(-5px); }
      }

      @media (max-width: 576px) {
        .hero-content h1 { font-size: 2rem; }
        .hero-content .typed-container { font-size: 0.9rem; }
        .vote-counter { font-size: 1.3rem; }
        .vote-stat-card { width: calc(100% - 1rem); max-width: 300px; } /* One card per row */
        .live-vote-feed { width: 90%; max-width: none; right: 5%; bottom: 70px; } /* Adjust position */
        .feed-toggle { bottom: 20px; right: 20px; width: 45px; height: 45px; }
        .voter-id-card { width: 240px; height: 145px; }
        footer { padding: 3rem 1rem; }
        /* Further reduce Lottie/Ballot size if needed on very small screens */
         #lottie-animation-container { max-width: 280px; height: 225px; }
         .ballot-box { width: 130px; height: 90px; }
      }
    </style>
</head>
<body>
    <!-- Header Section -->
    <div class="header-wrapper gradient-shift">
      <div class="parallax-bg"></div>
      <canvas id="particle-canvas"></canvas>

      <div class="hero-content container mx-auto px-4">
        <h1 class="animate__animated animate__zoomInDown" data-aos="zoom-in-down">Secure Online Voting Platform</h1>
        <div class="typed-container animate__animated animate__fadeInUp animate__delay-1s" data-aos="fade-up" data-aos-delay="200">
          <span id="typed-text"></span> <!-- Typed.js target -->
        </div>

        <!-- Lottie Animation (Now Larger) -->
        <div id="lottie-animation-container" class="float" data-aos="zoom-in" data-aos-delay="400"></div>

        <!-- Ballot Box Animation (Now Larger) -->
        <div class="ballot-box" data-aos="fade-up" data-aos-delay="600">
          <div class="ballot-slot"></div>
          <div class="ballot-paper" id="ballot-paper">
            <i class="fas fa-check ballot-checkmark" id="ballot-checkmark"></i>
          </div>
        </div>

        <!-- Vote Progress -->
        <div class="vote-progress-container" data-aos="fade-up" data-aos-delay="700">
          <div class="vote-progress-bar" id="vote-progress-bar" style="width: <?php echo $turnoutPercentage; ?>%;"></div>
        </div>

        <!-- Vote Counter -->
        <div class="vote-counter" id="vote-counter-container" data-aos="fade-up" data-aos-delay="800">
            Votes Cast: <span id="vote-count" class="counter-animation" data-target="<?php echo $totalVotes; ?>">0</span>
        </div>

        <!-- Vote Stats -->
        <div class="vote-stats-container">
          <div class="vote-stat-card" data-aos="fade-up" data-aos-delay="900">
            <div class="vote-stat-icon"><i class="fas fa-users"></i></div>
            <div class="vote-stat-number counter-animation" data-target="<?php echo $registeredVoters; ?>">0</div>
            <p class="vote-stat-label">Registered Voters</p>
          </div>
          <div class="vote-stat-card" data-aos="fade-up" data-aos-delay="1000">
             <div class="vote-stat-icon"><i class="fas fa-chart-pie"></i></div>
            <div class="vote-stat-number counter-animation" data-target="<?php echo $turnoutPercentage; ?>">0</div>
            <p class="vote-stat-label">Voter Turnout %</p>
          </div>
          <div class="vote-stat-card" data-aos="fade-up" data-aos-delay="1100">
             <div class="vote-stat-icon"><i class="fas fa-hourglass-half"></i></div>
            <div class="vote-stat-number counter-animation" data-target="18" id="hours-remaining-counter">0</div>
            <p class="vote-stat-label">Hours Remaining</p>
          </div>
        </div>

        <!-- Voter ID Card with Flip Animation -->
        <div class="voter-id-card" data-aos="flip-left" data-aos-delay="1200">
          <div class="voter-id-inner">
            <div class="voter-id-front">
               <div class="flex items-center justify-between w-full px-2">
                   <i class="fas fa-vote-yea text-2xl opacity-70"></i>
                   <h3 class="text-center">VOTER ID</h3>
                   <i class="fas fa-shield-alt text-2xl opacity-70"></i>
               </div>
              <div class="voter-id-photo">
                <i class="fas fa-user"></i>
              </div>
              <p class="text-center">Hover to see details</p>
            </div>
            <div class="voter-id-back">
              <h4 class="">Jeevasurya Palanisamy</h4>
              <p class=""><strong>ID:</strong> <span class="font-mono">JPS9876543</span></p>
              <p class=""><strong>Ward:</strong> Avinashi South</p>
              <p class=""><strong>Status:</strong> <span class="text-green-600 font-semibold">Eligible</span></p>
              <div class="voter-id-barcode"></div>
            </div>
          </div>
        </div>

        <!-- Vote Badge -->
        <div class="vote-badge animate__animated animate__bounceIn animate__delay-2s" data-aos="zoom-in-up" data-aos-delay="1300">
          <i class="fas fa-check-circle mr-1"></i> I Voted Securely!
        </div>

        <!-- Vote Button with Ripple Effect (Now Slightly Larger) -->
        <div class="vote-btn-container" data-aos="fade-up" data-aos-delay="1400">
          <button id="vote-btn" class="hero-btn pulse mt-4 inline-block" aria-label="Cast your vote - Login required">
             Cast Your Vote Now
             <span class="vote-btn-ripple"></span>
          </button>
        </div>
      </div>
    </div>

    <!-- Main Content -->
    <main class="container py-16 px-4">
      <section id="about" class="text-center py-12">
        <h2 class="text-3xl font-bold mb-4" data-aos="fade-up">Project Abstract</h2>
        <div class="bg-white rounded-lg p-8 mt-4 shadow-xl max-w-3xl mx-auto" data-aos="fade-up" data-aos-delay="200">
          <p class="text-lg leading-relaxed text-gray-700">
            Our Online Voting System, built with PHP, MySQL, HTML, CSS, and JavaScript, provides a <strong>secure, accessible, and efficient</strong> platform for conducting elections. It aims to increase voter turnout by offering a convenient alternative to traditional polling stations, while ensuring the integrity and confidentiality of every vote through robust security measures and transparent processes. Features include user registration, candidate profiles, real-time result tracking, and administrative oversight.
          </p>
        </div>
      </section>


    </main>

    <!-- Vote Success Modal (With Larger Checkmark) -->
    <div class="vote-success-container" id="vote-success-modal" aria-labelledby="success-title" role="alertdialog" aria-modal="true">
      <div class="vote-success-content">
        <div class="checkmark-circle">
          <div class="checkmark-circle-fill" id="checkmark-fill"></div>
          <i class="fas fa-check checkmark-circle-check" id="checkmark-check-icon"></i>
        </div>
        <h2 id="success-title" class="text-2xl font-bold mt-4 text-gray-800">Vote Successfully Cast!</h2>
        <p class="mt-2 text-gray-600">Thank you for participating in the election. Your voice matters!</p>
        <div class="mt-6">
          <button class="hero-btn bg-success-color hover:bg-emerald-600" id="close-success-modal">
             Awesome!
             <span class="vote-btn-ripple"></span>
          </button>
        </div>
      </div>
    </div>

    <!-- Live Vote Feed Toggle Button -->
    <button class="feed-toggle" id="feed-toggle" aria-label="Toggle Live Vote Feed" aria-expanded="false">
      <i class="fas fa-stream"></i>
    </button>

    <!-- Live Vote Feed Panel -->
    <div class="live-vote-feed" id="live-vote-feed" aria-live="polite">
      <div class="feed-header">
        <h3 id="feed-title">Live Voting Feed</h3>
        <button id="close-feed" aria-label="Close Live Vote Feed">
          <i class="fas fa-times"></i>
        </button>
      </div>
      <div class="feed-content" id="feed-content">
          <!-- Vote entries will be added here by JavaScript -->
           <?php if (empty($recentVotes)): ?>
               <div class="text-center text-gray-500 p-4" id="feed-placeholder">No recent votes yet.</div>
           <?php else: ?>
               <div class="text-center text-gray-500 p-4" id="feed-placeholder" style="display: none;">Loading recent votes...</div>
               <!-- Entries added by JS -->
           <?php endif; ?>
      </div>
    </div>

    <!-- Enhanced Footer -->
    <footer>
      <div class="container mx-auto px-4">
        <h2 class="text-3xl font-bold text-center mb-10" data-aos="fade-up">Meet The Development Team</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">

          <div data-aos="zoom-in-up" data-aos-delay="100">
            <div class="team-card team-head text-center">
              <h3 class="text-xl font-semibold text-white mb-1">Jeevasurya P</h3>
              <p class="text-accent-color text-sm font-medium">Team Lead & Full-Stack Dev</p>
              <div class="social-icons mt-4">
                <a href="#" aria-label="Jeevasurya's LinkedIn"><i class="fab fa-linkedin"></i></a>
                <a href="#" aria-label="Jeevasurya's Github"><i class="fab fa-github"></i></a>
                <a href="#" aria-label="Jeevasurya's Portfolio"><i class="fas fa-globe"></i></a>
              </div>
            </div>
          </div>
           <div data-aos="zoom-in-up" data-aos-delay="200">
            <div class="team-card text-center">
              <h3 class="text-xl font-semibold text-white mb-1">Hariharan R</h3>
              <p class="text-gray-300 text-sm">Front-end Specialist</p>
              <div class="social-icons mt-4">
                 <a href="#" aria-label="Hariharan's LinkedIn"><i class="fab fa-linkedin"></i></a>
                 <a href="#" aria-label="Hariharan's Github"><i class="fab fa-github"></i></a>
              </div>
            </div>
          </div>
           <div data-aos="zoom-in-up" data-aos-delay="300">
            <div class="team-card text-center">
              <h3 class="text-xl font-semibold text-white mb-1">Gokulraj M</h3>
              <p class="text-gray-300 text-sm">Back-end Developer</p>
               <div class="social-icons mt-4">
                 <a href="#" aria-label="Gokulraj's LinkedIn"><i class="fab fa-linkedin"></i></a>
                 <a href="#" aria-label="Gokulraj's Github"><i class="fab fa-github"></i></a>
              </div>
            </div>
          </div>
           <div data-aos="zoom-in-up" data-aos-delay="400">
            <div class="team-card text-center">
              <h3 class="text-xl font-semibold text-white mb-1">Inbaraj V</h3>
              <p class="text-gray-300 text-sm">UI/UX Designer</p>
              <div class="social-icons mt-4">
                 <a href="#" aria-label="Inbaraj's LinkedIn"><i class="fab fa-linkedin"></i></a>
                 <a href="#" aria-label="Inbaraj's Dribbble"><i class="fab fa-dribbble"></i></a>
              </div>
            </div>
          </div>
           <div data-aos="zoom-in-up" data-aos-delay="500">
            <div class="team-card text-center">
              <h3 class="text-xl font-semibold text-white mb-1">Mathan R</h3>
              <p class="text-gray-300 text-sm">Database Architect</p>
               <div class="social-icons mt-4">
                 <a href="#" aria-label="Mathan's LinkedIn"><i class="fab fa-linkedin"></i></a>
                 <a href="#" aria-label="Mathan's Github"><i class="fab fa-github"></i></a>
              </div>
            </div>
          </div>
          <div data-aos="zoom-in-up" data-aos-delay="600">
            <div class="team-card text-center">
              <h3 class="text-xl font-semibold text-white mb-1">Harinesh N</h3>
              <p class="text-gray-300 text-sm">Security & Testing</p>
              <div class="social-icons mt-4">
                 <a href="#" aria-label="Harinesh's LinkedIn"><i class="fab fa-linkedin"></i></a>
                 <a href="#" aria-label="Harinesh's Github"><i class="fab fa-github"></i></a>
              </div>
            </div>
          </div>
        </div>
        <div class="text-center mt-12 border-t border-gray-700 pt-6">
          <p class="mb-1 text-sm text-gray-400">© <?php echo date("Y"); ?> Online Voting System. All rights reserved.</p>
          <small class="text-gray-500">Empowering Democracy Through Technology</small>
        </div>
      </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lottie-web@5.12.2/build/lottie.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.9.2/dist/confetti.browser.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/typed.js/2.0.12/typed.min.js"></script>
    <!-- Keep Font Awesome JS if needed for dynamic icons, otherwise CSS is enough -->
    <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js" integrity="sha384-k6RqeWeci5ZR/Lv4MR0sA0FfDOM8x2z4z5e5a5e5a5e5a5e5a5e5a5e5a5e5a" crossorigin="anonymous"></script> -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/particles.js/2.0.0/particles.min.js"></script>


    <script>
      document.addEventListener('DOMContentLoaded', function() {
        // Strict mode helps catch common coding errors
        'use strict';

        // --- Configuration ---
        const LOTTIE_ANIMATION_PATH = 'https://assets10.lottiefiles.com/packages/lf20_o8jwjd6r.json'; // Different Lottie animation
        // Use PHP data safely encoded
        const RECENT_VOTES_DATA = <?php echo json_encode($recentVotes, JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP | JSON_UNESCAPED_UNICODE); ?>;
        const HOURS_REMAINING_ELEMENT_ID = 'hours-remaining-counter';
        const VOTE_END_HOUR = 18; // Configure the hour when voting ends (e.g., 18 for 6 PM)

        // --- Initialization ---
        initializeLibraries();
        initializeUI();
        initializeAnimations();
        setupEventListeners();

        console.log("Voting System UI Initialized"); // Debug message

        // --- Function Definitions ---

        function initializeLibraries() {
          // Initialize AOS (Animate on Scroll)
          if (typeof AOS !== 'undefined') {
            AOS.init({
              duration: 800, // Slightly faster duration
              easing: 'ease-in-out-quad', // Smoother easing
              once: true, // Animate elements only once
              offset: 50, // Trigger animation slightly earlier
            });
          } else {
            console.warn('AOS library not found.');
          }

          // Initialize Typed.js for hero description
          const typedTarget = document.getElementById('typed-text');
          if (typeof Typed !== 'undefined' && typedTarget) {
            try {
              new Typed(typedTarget, {
                strings: [
                  "Exercise your right to vote securely from anywhere.",
                  "A transparent and modern solution for democratic participation.",
                  "Ensuring integrity and accessibility in every election.",
                  "Your voice, your vote, securely counted online."
                ],
                typeSpeed: 40,
                backSpeed: 25,
                backDelay: 2500,
                startDelay: 500,
                loop: true,
                showCursor: true,
                cursorChar: '|',
                smartBackspace: true // Improves typing feel
              });
            } catch (e) {
              console.error("Typed.js initialization failed:", e);
              typedTarget.textContent = "Exercise your right to vote securely from anywhere."; // Fallback text
            }
          } else {
             console.warn('Typed.js library or target element not found.');
             if(typedTarget) typedTarget.textContent = "Exercise your right to vote securely from anywhere."; // Fallback text
          }
        }

        function initializeUI() {
           // Initialize Lottie Animation
           const lottieContainer = document.getElementById('lottie-animation-container');
            if (typeof lottie !== 'undefined' && lottieContainer && LOTTIE_ANIMATION_PATH) {
                try {
                    const lottieAnim = lottie.loadAnimation({
                        container: lottieContainer,
                        renderer: 'svg',
                        loop: true, // Loop this animation
                        autoplay: true, // Autoplay
                        path: LOTTIE_ANIMATION_PATH,
                    });

                    // Optional: Stop loop on hover, play on click example
                    lottieContainer.addEventListener('mouseenter', () => { if(lottieAnim) lottieAnim.pause(); });
                    lottieContainer.addEventListener('mouseleave', () => { if(lottieAnim) lottieAnim.play(); });
                    lottieContainer.addEventListener('click', () => {
                        if(!lottieAnim) return;
                        lottieAnim.stop();
                        lottieAnim.play();
                        lottieContainer.classList.add('vote-pop');
                        lottieContainer.addEventListener('animationend', () => {
                            lottieContainer.classList.remove('vote-pop');
                        }, { once: true });
                    });

                } catch (e) {
                    console.error("Lottie initialization failed:", e);
                }
            } else {
                console.warn('Lottie library, container, or path not available.');
            }

          // Initialize Counters
          initializeCounters();

          // Initialize Particle System
          initParticleSystem();

          // Initialize Live Feed
          initializeLiveFeed(RECENT_VOTES_DATA);

          // Update Remaining Hours (initial call)
          updateRemainingHours();
          // Set interval to update remaining hours periodically
          // Update every minute for more responsive countdown near the end
          setInterval(updateRemainingHours, 60 * 1000); // Update every minute
        }

        function initializeCounters() {
            const counterElements = document.querySelectorAll('.counter-animation');
            if (counterElements.length === 0) return;

            const observer = new IntersectionObserver((entries, obs) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const el = entry.target;
                        // Prevent re-animating if already done
                        if (el.classList.contains('counter-animated')) return;

                        const target = parseInt(el.getAttribute('data-target'), 10);
                        if (isNaN(target)) return; // Skip if target is not a number

                        el.innerText = '0'; // Start from 0
                        el.classList.add('counter-animated'); // Mark as animated

                        let current = 0;
                        const duration = 1500; // Animation duration in ms
                        const stepTime = Math.max(16, duration / (target || 1)); // Adjust step time based on target value for smoother anim on large numbers
                        const increment = target / (duration / stepTime);


                        const updateCounter = () => {
                            current += increment;
                            if (current < target) {
                                el.innerText = Math.ceil(current).toLocaleString(); // Format number
                                requestAnimationFrame(updateCounter);
                            } else {
                                el.innerText = target.toLocaleString(); // Ensure final value is exact
                            }
                        };
                        requestAnimationFrame(updateCounter);
                        obs.unobserve(el); // Stop observing once animated
                    }
                });
            }, { threshold: 0.3 }); // Trigger when 30% visible

            counterElements.forEach(counter => {
                observer.observe(counter);
            });
        }

        function updateRemainingHours() {
            const hoursElement = document.getElementById(HOURS_REMAINING_ELEMENT_ID);
            if (!hoursElement) return;

            const now = new Date();
            const endOfVoting = new Date();
            // Set end time to configured hour today
            endOfVoting.setHours(VOTE_END_HOUR, 0, 0, 0);

            if (now >= endOfVoting) {
                hoursElement.innerText = "0";
                hoursElement.setAttribute('data-target', "0"); // Update target for consistency
                // Optionally update label or style to indicate voting has ended
                const labelElement = hoursElement.closest('.vote-stat-card')?.querySelector('.vote-stat-label');
                if (labelElement) labelElement.textContent = "Voting Ended";
            } else {
                const diffMs = endOfVoting - now;
                const hoursRemaining = Math.max(0, Math.floor(diffMs / (1000 * 60 * 60))); // Use floor for whole hours
                const minutesRemaining = Math.max(0, Math.floor((diffMs % (1000 * 60 * 60)) / (1000 * 60)));

                // Display hours, or minutes if less than 1 hour left
                if (hoursRemaining > 0) {
                    hoursElement.innerText = hoursRemaining.toLocaleString();
                    hoursElement.setAttribute('data-target', hoursRemaining.toString());
                    const labelElement = hoursElement.closest('.vote-stat-card')?.querySelector('.vote-stat-label');
                    if (labelElement) labelElement.textContent = `Hour${hoursRemaining !== 1 ? 's' : ''} Remaining`;
                } else {
                    hoursElement.innerText = minutesRemaining.toLocaleString();
                     hoursElement.setAttribute('data-target', minutesRemaining.toString()); // Target minutes now
                    const labelElement = hoursElement.closest('.vote-stat-card')?.querySelector('.vote-stat-label');
                    if (labelElement) labelElement.textContent = `Minute${minutesRemaining !== 1 ? 's' : ''} Remaining`;
                }

            }
        }

        function initializeAnimations() {
           // Ballot Drop Animation Trigger
           const ballotPaper = document.getElementById('ballot-paper');
           const ballotCheckmark = document.getElementById('ballot-checkmark');
           const ballotBoxElement = document.querySelector('.ballot-box');

           if (ballotPaper && ballotCheckmark && ballotBoxElement) {
               // Use Intersection Observer for better performance
                const ballotObserver = new IntersectionObserver((entries, obs) => {
                   entries.forEach(entry => {
                       if (entry.isIntersecting) {
                            // Check if animation already played to prevent re-triggering on scroll
                            if (!ballotPaper.classList.contains('ballot-drop')) {
                                setTimeout(() => { // Add a slight delay after view
                                    ballotPaper.classList.add('ballot-drop');
                                    ballotCheckmark.classList.add('checkmark-pop');
                                }, 300);
                            }
                           // Don't unobserve if you want it to re-animate if scrolled out/in
                           // obs.unobserve(entry.target); // Observe only once if needed
                       }
                   });
               }, { threshold: 0.5 }); // Trigger when 50% visible
                ballotObserver.observe(ballotBoxElement); // Observe the box
           }

           // Add more complex GSAP animations here if needed later
        }

        function setupEventListeners() {
          // Button Ripple Effect
           document.querySelectorAll('.hero-btn, .feed-toggle').forEach(button => {
               button.addEventListener('click', (e) => {
                   const ripple = button.querySelector('.vote-btn-ripple');
                    if (ripple) {
                        // Clear previous ripple animation timeout if any
                        if (ripple.dataset.animationTimeout) {
                            clearTimeout(parseInt(ripple.dataset.animationTimeout));
                            ripple.classList.remove('ripple-animate');
                        }

                        // Trigger reflow to restart animation if needed
                        // void ripple.offsetWidth; // Sometimes needed, sometimes not

                         // Set position and start animation
                        const rect = button.getBoundingClientRect();
                        const size = Math.max(rect.width, rect.height) * 2.5; // Make ripple larger
                        const x = e.clientX - rect.left - size / 2;
                        const y = e.clientY - rect.top - size / 2;

                        ripple.style.width = ripple.style.height = `${size}px`;
                        ripple.style.left = `${x}px`;
                        ripple.style.top = `${y}px`;

                        ripple.classList.add('ripple-animate');

                         // Clean up animation class after it finishes
                        const timeoutId = setTimeout(() => {
                           ripple.classList.remove('ripple-animate');
                           delete ripple.dataset.animationTimeout;
                        }, 800); // Match animation duration
                        ripple.dataset.animationTimeout = timeoutId.toString();
                    }

                    // Specific button actions
                    if (button.id === 'vote-btn') {
                        // Redirect to the main voting page
                         console.log("Redirecting to main.php...");
                         window.location.href = 'main.php'; // Make sure main.php exists
                    } else if (button.id === 'close-success-modal') {
                        hideVoteSuccessModal();
                    } else if (button.id === 'feed-toggle') {
                        toggleLiveFeed();
                    } else if (button.id === 'close-feed') {
                        hideLiveFeed();
                    }
               });
           });


          // Close Success Modal Listener (added within button loop above)
          // Close Live Feed Listener (added within button loop above)
          // Toggle Live Feed Listener (added within button loop above)

          // Close modal on background click
          const successModal = document.getElementById('vote-success-modal');
          if (successModal) {
              successModal.addEventListener('click', (e) => {
                  // Ensure click is directly on the overlay, not the content inside
                  if (e.target === successModal) {
                      hideVoteSuccessModal();
                  }
              });
          }
           // Close modal with Escape key
           document.addEventListener('keydown', (e) => {
                if (e.key === 'Escape' && successModal && successModal.classList.contains('vote-success-show')) {
                    hideVoteSuccessModal();
                }
            });

           // Optional: Parallax effect on scroll (if needed and not handled by CSS)
           // window.addEventListener('scroll', () => { ... });

            // Adjust particle canvas size on window resize
           window.addEventListener('resize', debounce(() => {
               const canvas = document.getElementById('particle-canvas');
               // Check if particle system is active (canvas exists and particles.js is loaded)
               if (canvas && typeof particlesJS !== 'undefined' && canvas.offsetParent !== null) {
                   console.log("Resizing particle canvas");
                   canvas.width = canvas.offsetWidth; // Use offsetWidth for accurate size
                   canvas.height = canvas.offsetHeight; // Use offsetHeight
                   // Re-initialize particlesJS on the existing canvas ID if needed,
                   // This might be heavy, consider if just resizing the canvas is enough.
                   // If using the custom particle code below, call initParticleSystem() again.
                   // initParticleSystem(); // Only if using the custom system below
               }
           }, 250)); // Debounce resize handler
        }

        // --- Voting System Specific Functions ---

        function initializeLiveFeed(recentVotes) {
            const feedContent = document.getElementById('feed-content');
            const placeholder = document.getElementById('feed-placeholder');
            if (!feedContent || !placeholder) {
                console.warn("Live feed container or placeholder not found.");
                return;
            }

            // Clear only if placeholder exists (it's removed on first real entry)
            if (placeholder) {
               feedContent.innerHTML = ''; // Clear everything
               feedContent.appendChild(placeholder); // Add placeholder back
               placeholder.style.display = 'block'; // Ensure placeholder is visible
               placeholder.textContent = 'Loading recent votes...'; // Reset text
            } else {
                 feedContent.innerHTML = ''; // Clear if no placeholder found (shouldn't happen ideally)
            }


            if (recentVotes && recentVotes.length > 0) {
                placeholder.style.display = 'none'; // Hide placeholder
                recentVotes.forEach((vote, index) => {
                    // Validate data slightly before adding
                     if (vote && vote.voter_time) {
                         // Add votes with a staggered delay for animation effect
                        setTimeout(() => {
                            addVoteEntryToFeed(
                                vote.voter_id_string ? `...${vote.voter_id_string.substr(-4)}` : 'Voter', // Mask voter ID
                                vote.candidate_name || 'Unknown Candidate',
                                vote.politic_name || '', // Show empty string if no party
                                vote.voter_time // Pass the raw time string/object
                            );
                        }, index * 200); // Stagger animation
                     } else {
                         console.warn("Skipping invalid vote entry in feed:", vote);
                     }
                });
            } else {
                 placeholder.textContent = 'No recent votes to display.'; // Update placeholder text if empty
            }
        }

        function addVoteEntryToFeed(voterId, candidateName, partyName, voteTimeString) {
            const feedContent = document.getElementById('feed-content');
            if (!feedContent) return;

             // Remove placeholder if it exists and this is the first entry
             const placeholder = document.getElementById('feed-placeholder');
             if (placeholder && feedContent.contains(placeholder)) {
                 placeholder.style.display = 'none';
             }

            const voteEntry = document.createElement('div');
            voteEntry.className = 'vote-entry'; // Animation starts via CSS (opacity 0, transform)

            let timeString = 'Just now'; // Default
            try {
                // Attempt to parse the time string (adjust format if needed based on DB)
                const voteTime = new Date(voteTimeString);
                 // Check if the date is valid
                 if (!isNaN(voteTime.getTime())) {
                    timeString = voteTime.toLocaleTimeString([], { hour: 'numeric', minute: '2-digit', hour12: true });
                 } else {
                     console.warn("Invalid date format received for feed:", voteTimeString);
                 }
            } catch (e) {
                console.error("Error parsing vote time for feed:", e);
            }


            voteEntry.innerHTML = `
              <div class="flex justify-between items-start gap-2"> <!-- Added gap -->
                  <div class="flex-grow"> <!-- Allow text to wrap -->
                      <div class="font-semibold text-sm">${voterId} voted for</div>
                      <div class="text-base text-primary-dark font-medium break-words">${candidateName}</div> <!-- Allow candidate name to wrap -->
                      ${partyName ? `<div class="text-xs text-gray-500">${partyName}</div>` : ''}
                  </div>
                  <div class="vote-time text-xs whitespace-nowrap flex-shrink-0">${timeString}</div> <!-- Prevent time from wrapping -->
              </div>
            `;

            feedContent.prepend(voteEntry); // Add to the top

            // Trigger the animation by adding the 'show' class after a tiny delay
            requestAnimationFrame(() => {
                 setTimeout(() => {
                    voteEntry.classList.add('show');
                }, 10); // Small delay ensures transition works
            });


            // Limit the number of entries shown
            const maxEntries = 15;
            while (feedContent.children.length > maxEntries) {
                 // Check if the last child is not the placeholder before removing
                 const lastChild = feedContent.lastElementChild;
                 if (lastChild && lastChild.id !== 'feed-placeholder') {
                    feedContent.removeChild(lastChild); // Simple removal
                 } else {
                     break; // Stop if only placeholder is left
                 }
            }
        }

        function toggleLiveFeed() {
             const liveFeed = document.getElementById('live-vote-feed');
             const toggleButton = document.getElementById('feed-toggle');
             if (liveFeed && toggleButton) {
                 const isShown = liveFeed.classList.toggle('show-feed');
                 toggleButton.setAttribute('aria-expanded', isShown);
                 // Change icon based on state
                 toggleButton.querySelector('i').className = isShown ? 'fas fa-times' : 'fas fa-stream';
             }
        }

         function hideLiveFeed() {
             const liveFeed = document.getElementById('live-vote-feed');
             const toggleButton = document.getElementById('feed-toggle');
             if (liveFeed && toggleButton) {
                 liveFeed.classList.remove('show-feed');
                 toggleButton.setAttribute('aria-expanded', 'false');
                  toggleButton.querySelector('i').className = 'fas fa-stream'; // Reset icon
             }
        }


        function showVoteSuccessModal() {
          const modal = document.getElementById('vote-success-modal');
          const fill = document.getElementById('checkmark-fill');
          const check = document.getElementById('checkmark-check-icon');
          if (!modal || !fill || !check) return;

          // Ensure modal is focusable for accessibility
          modal.setAttribute('tabindex', '-1');

          // Reset animations before showing
          fill.classList.remove('circle-fill-animate');
          check.classList.remove('circle-check-animate');
          // Trigger reflow to ensure reset takes effect before adding class again
          void fill.offsetWidth;

          modal.classList.add('vote-success-show');
           // Focus the modal or a primary action inside it after showing
           // Focusing the close button is a good practice
           const closeButton = document.getElementById('close-success-modal');
           if(closeButton) {
               setTimeout(() => closeButton.focus(), 50); // Delay focus slightly
           } else {
               setTimeout(() => modal.focus(), 50);
           }


          // Start animations
          fill.classList.add('circle-fill-animate');
          check.classList.add('circle-check-animate');

          // Trigger Confetti
          if (typeof confetti !== 'undefined') {
             // Slightly more celebratory confetti
             const duration = 1.5 * 1000; // 1.5 seconds
             const animationEnd = Date.now() + duration;
             const defaults = { startVelocity: 30, spread: 360, ticks: 60, zIndex: 1300 }; // Ensure confetti is above modal overlay

             function randomInRange(min, max) {
               return Math.random() * (max - min) + min;
             }

             const interval = setInterval(function() {
               const timeLeft = animationEnd - Date.now();

               if (timeLeft <= 0) {
                 return clearInterval(interval);
               }

               const particleCount = 50 * (timeLeft / duration);
               // since particles fall down, start a bit higher than random
               confetti(Object.assign({}, defaults, { particleCount, origin: { x: randomInRange(0.1, 0.3), y: Math.random() - 0.2 } }));
               confetti(Object.assign({}, defaults, { particleCount, origin: { x: randomInRange(0.7, 0.9), y: Math.random() - 0.2 } }));
             }, 250);

          } else {
              console.warn("Confetti library not loaded.");
          }
        }

        function hideVoteSuccessModal() {
          const modal = document.getElementById('vote-success-modal');
          if (modal) {
            modal.classList.remove('vote-success-show');
            modal.removeAttribute('tabindex'); // Remove tabindex when hidden
             // Optional: Reset animation classes after hiding if needed
             // setTimeout(() => {
             //    const fill = document.getElementById('checkmark-fill');
             //    const check = document.getElementById('checkmark-check-icon');
             //    if(fill) fill.classList.remove('circle-fill-animate');
             //    if(check) check.classList.remove('circle-check-animate');
             // }, 400); // Delay matches transition time
          }
        }

        // --- Particle System (Using particles.js library if available) ---
        function initParticleSystem() {
            const canvas = document.getElementById('particle-canvas');
            if (typeof particlesJS === 'undefined' || !canvas) {
                console.warn('particles.js library or canvas element not found. Skipping particle background.');
                 if(canvas) canvas.style.display = 'none'; // Hide the canvas if lib not loaded
                return;
            }
            // Ensure canvas is visible before initializing
             if (canvas.offsetParent === null) {
                 console.log("Particle canvas is hidden, skipping initialization until visible.");
                 return;
             }

            console.log("Initializing particles.js");
             particlesJS('particle-canvas', {
                "particles": {
                    "number": {
                    "value": window.innerWidth < 768 ? 30 : 60, // Fewer particles on mobile
                    "density": {
                        "enable": true,
                        "value_area": 800
                    }
                    },
                    "color": {
                    "value": "#ffffff"
                    },
                    "shape": {
                    "type": "circle",
                    "stroke": {
                        "width": 0,
                        "color": "#000000"
                    },
                    "polygon": {
                        "nb_sides": 5
                    },
                    "image": {
                        "src": "img/github.svg",
                        "width": 100,
                        "height": 100
                    }
                    },
                    "opacity": {
                    "value": 0.4, // Slightly more visible
                    "random": true, // Random opacity
                    "anim": {
                        "enable": true,
                        "speed": 0.2, // Slow fade animation
                        "opacity_min": 0.1,
                        "sync": false
                    }
                    },
                    "size": {
                    "value": 3,
                    "random": true,
                    "anim": {
                        "enable": false,
                        "speed": 40,
                        "size_min": 0.1,
                        "sync": false
                    }
                    },
                    "line_linked": {
                    "enable": false, // Disable lines between particles
                    "distance": 150,
                    "color": "#ffffff",
                    "opacity": 0.4,
                    "width": 1
                    },
                    "move": {
                    "enable": true,
                    "speed": 0.5, // Slower speed
                    "direction": "none",
                    "random": true, // Move in random directions
                    "straight": false,
                    "out_mode": "out", // Particles leave the canvas area
                    "bounce": false,
                    "attract": {
                        "enable": false,
                        "rotateX": 600,
                        "rotateY": 1200
                    }
                    }
                },
                "interactivity": {
                    "detect_on": "canvas",
                    "events": {
                    "onhover": {
                        "enable": false, // Disable interactivity on hover
                        "mode": "repulse"
                    },
                    "onclick": {
                        "enable": false, // Disable interactivity on click
                        "mode": "push"
                    },
                    "resize": true
                    },
                    "modes": {
                    "grab": {
                        "distance": 400,
                        "line_linked": {
                        "opacity": 1
                        }
                    },
                    "bubble": {
                        "distance": 400,
                        "size": 40,
                        "duration": 2,
                        "opacity": 8,
                        "speed": 3
                    },
                    "repulse": {
                        "distance": 200,
                        "duration": 0.4
                    },
                    "push": {
                        "particles_nb": 4
                    },
                    "remove": {
                        "particles_nb": 2
                    }
                    }
                },
                "retina_detect": true
             });

             // Optional: Use Intersection Observer to pause/resume if needed (particles.js doesn't have built-in pause)
             // Requires storing the pJS instance and interacting with its internal state, which can be complex.
             // For simplicity, let it run unless performance is a major issue.

              // Add resize listener to ensure particlesJS updates layout correctly
              window.addEventListener('resize', debounce(() => {
                  if (window.pJSDom && window.pJSDom[0]) {
                      const pJS = window.pJSDom[0].pJS;
                      pJS.fn.vendors.onresize();
                      console.log("Triggered pJS resize");
                  }
              }, 250));

        }


        // --- Utility Functions ---
        function debounce(func, wait) {
            let timeout;
            return function executedFunction(...args) {
                const later = () => {
                    clearTimeout(timeout);
                    func(...args);
                };
                clearTimeout(timeout);
                timeout = setTimeout(later, wait);
            };
        }

        // Example: Trigger success modal for demonstration after a delay
        // Comment this out for production use
        // setTimeout(() => {
        //     console.log("Triggering demo success modal");
        //     showVoteSuccessModal();
        // }, 5000); // Show after 5 seconds

      }); // End DOMContentLoaded
    </script>

</body>
</html>