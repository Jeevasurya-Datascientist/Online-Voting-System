
<?php
session_start();

// --- Database Connection ---
$servername = "localhost";
$username = "root"; // Replace if needed
$password = "";     // Replace if needed
$dbname = "online_voting_system";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    error_log("Database connection error: " . $conn->connect_error);
    die("A critical connection error occurred. Please contact the administrator.");
}

// --- Variables ---
$error_message = "";
$success_message = "";
$invalid_fields = [];
$form_has_error = false;

// --- CAPTCHA Setup ---
function generateCaptcha($length = 6) {
    $characters = '23456789ABCDEFGHJKLMNPQRSTUVWXYZ';
    return substr(str_shuffle($characters), 0, $length);
}
if (!isset($_SESSION['captcha'])) {
    $_SESSION['captcha'] = generateCaptcha();
}

// --- Form Processing (POST Request) ---
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Sanitize inputs
    $username_input = filter_input(INPUT_POST, 'username', FILTER_SANITIZE_STRING);
    $voter_id_input = filter_input(INPUT_POST, 'voter_id', FILTER_SANITIZE_STRING);
    $dob_input_raw = filter_input(INPUT_POST, 'dob', FILTER_SANITIZE_STRING);
    $email_input = filter_input(INPUT_POST, 'email', FILTER_SANITIZE_EMAIL);
    $captcha_input_raw = filter_input(INPUT_POST, 'captcha', FILTER_SANITIZE_STRING);

    // Trim inputs
    $username = trim($username_input ?? '');
    $voter_id = trim($voter_id_input ?? '');
    $dob_input = trim($dob_input_raw ?? '');
    $email = trim($email_input ?? '');
    $captcha_input = trim($captcha_input_raw ?? '');

    // Validation
    if (empty($username)) {
        $error_message = "Full Name is required.";
        $invalid_fields[] = 'username';
    } elseif (empty($voter_id)) {
        $error_message = "Voter ID is required.";
        $invalid_fields[] = 'voter_id';
    } elseif (!preg_match('/^[A-Z]{3}[0-9]{7}$/i', $voter_id)) {
        $error_message = "Voter ID format must be ABC1234567.";
        $invalid_fields[] = 'voter_id';
    } elseif (empty($dob_input)) {
        $error_message = "Date of Birth is required.";
        $invalid_fields[] = 'dob';
    } else {
        // Validate DoB format and age
        $dob = DateTime::createFromFormat('Y-m-d', $dob_input);
        if (!$dob || $dob->format('Y-m-d') !== $dob_input) {
            $error_message = "Invalid Date of Birth format. Use YYYY-MM-DD.";
            $invalid_fields[] = 'dob';
        } elseif ($dob > (new DateTime())->modify('-18 years')) {
            $error_message = "You must be at least 18 years old to vote.";
            $invalid_fields[] = 'dob';
        } elseif ($dob < (new DateTime())->modify('-100 years')) {
            $error_message = "Date of Birth is too far in the past.";
            $invalid_fields[] = 'dob';
        }
    }
    if (empty($email)) {
        $error_message = "Email Address is required.";
        $invalid_fields[] = 'email';
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $error_message = "Invalid Email Address format.";
        $invalid_fields[] = 'email';
    } elseif (empty($captcha_input)) {
        $error_message = "Security Code is required.";
        $invalid_fields[] = 'captcha';
    } elseif (!isset($_SESSION['captcha']) || strtoupper($captcha_input) !== $_SESSION['captcha']) {
        $error_message = "Invalid Security Code.";
        $invalid_fields[] = 'captcha';
        $_SESSION['captcha'] = generateCaptcha();
    }

    // If validation passes, proceed with database check
    if (empty($error_message)) {
        $voter_id_upper = strtoupper($voter_id);
        $stmt = $conn->prepare("SELECT id, name, has_voted FROM voters WHERE name = ? AND voter_id = ? AND dob = ? AND email = ?");
        if ($stmt) {
            $stmt->bind_param("ssss", $username, $voter_id_upper, $dob_input, $email);
            if ($stmt->execute()) {
                $result = $stmt->get_result();
                if ($result->num_rows === 1) {
                    $user = $result->fetch_assoc();
                    if ($user['has_voted'] == 1) {
                        $error_message = "This voter has already cast their vote.";
                        $invalid_fields = ['username', 'voter_id', 'dob', 'email', 'captcha'];
                        $_SESSION['captcha'] = generateCaptcha();
                    } else {
                        session_regenerate_id(true);
                        $_SESSION['user_id'] = $user['id'];
                        $_SESSION['user_name'] = $user['name'];
                        $_SESSION['voter_id_logged'] = $voter_id_upper;
                        $_SESSION['is_voter_logged_in'] = true;
                        $success_message = "Authentication successful! Redirecting to voting page...";
                        $_POST = array();
                        unset($_SESSION['captcha']);
                    }
                } else {
                    $error_message = "Invalid credentials or voter not found.";
                    $invalid_fields = ['username', 'voter_id', 'dob', 'email', 'captcha'];
                    $_SESSION['captcha'] = generateCaptcha();
                }
            } else {
                $error_message = "An error occurred during login. Please try again.";
                error_log("SQL Execute Error: " . $stmt->error);
                $_SESSION['captcha'] = generateCaptcha();
            }
            $stmt->close();
        } else {
            $error_message = "A database error occurred. Please contact support.";
            error_log("SQL Prepare Error: " . $conn->error);
            $_SESSION['captcha'] = generateCaptcha();
        }
    }
    if (!empty($error_message)) {
        $form_has_error = true;
    }
}

// --- AJAX CAPTCHA Refresh Handling ---
if (isset($_GET['refresh_captcha']) && $_GET['refresh_captcha'] == 'true') {
    if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest') {
        $_SESSION['captcha'] = generateCaptcha();
        header('Content-Type: application/json');
        header('Cache-Control: no-store, no-cache, must-revalidate, max-age=0');
        header('Cache-Control: post-check=0, pre-check=0', false);
        header('Pragma: no-cache');
        echo json_encode(['captcha' => $_SESSION['captcha']]);
        exit();
    } else {
        http_response_code(403); echo "Forbidden"; exit();
    }
}
// --- Close Connection ---
$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voter Login - Republic of India Online Voting Portal</title>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🗳️</text></svg>">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <!-- Flatpickr CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.css" integrity="sha512-MQXduO8IQnJVq1qmySpN87QQkiR1bZHtorbJBD0tzy7/0U9+YIC93QWHeGTEo3JyXmtBBuyydqtQoCegbqAvXg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <style>
        :root {
            --saffron: #FF9933;
            --white: #FFFFFF;
            --green: #138808;
            --navy: #000080;
            --light-saffron: #FFF2E0;
            --light-green: #E8F5E9;
            --light-red: #ffebee;
            --text-dark: #212529;
            --text-light: #495057;
            --border-color: #ced4da;
            --border-focus-color: var(--navy);
            --base-font-size: 17px;
            --chakra-size: 14vh;
            --chakra-min-size: 80px;
        }

        /* --- Animations --- */
        @keyframes fadeInSlideUp { from { opacity: 0; transform: translateY(25px); } to { opacity: 1; transform: translateY(0); } }
        @keyframes shake { 10%, 90% { transform: translateX(-3px); } 20%, 80% { transform: translateX(5px); } 30%, 50%, 70% { transform: translateX(-6px); } 40%, 60% { transform: translateX(6px); } }
        .shake-error { animation: shake 0.6s cubic-bezier(.36,.07,.19,.97) both; }
        @keyframes pulse { 0%, 100% { transform: scale(1); opacity: 1; } 50% { transform: scale(1.02); opacity: 0.98; } }
        @keyframes spinChakra { from { transform: translate(-50%, -50%) rotate(0deg); } to { transform: translate(-50%, -50%) rotate(360deg); } }
        @keyframes subtleShine { 0% { background-position: 200% 0; } 100% { background-position: -200% 0; } }

        /* --- Base & Background Styles --- */
        html { font-size: var(--base-font-size); }
        body { margin: 0; font-family: 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif; background-color: var(--white); position: relative; }
        .animated-flag-background { position: fixed; top: 0; left: 0; right: 0; bottom: 0; z-index: -1; display: flex; flex-direction: column; overflow: hidden; }
        .bg-band { flex: 1; width: 100%; position: relative; overflow: hidden; }
        .bg-saffron { background-color: var(--saffron); }
        .bg-white { background-color: var(--white); }
        .bg-green { background-color: var(--green); }
        .animated-flag-background::after { content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: linear-gradient(110deg, transparent 40%, rgba(255, 255, 255, 0.2) 50%, transparent 60%); background-size: 300% 100%; animation: subtleShine 8s linear infinite; pointer-events: none; z-index: 2; }
        .ashoka-chakra { position: absolute; top: 50%; left: 50%; width: max(var(--chakra-min-size), var(--chakra-size)); height: max(var(--chakra-min-size), var(--chakra-size)); animation: spinChakra 30s linear infinite; z-index: 1; transform-origin: center center; will-change: transform; object-fit: contain; }

        /* --- Content Wrapper & Containers --- */
        .content-wrapper { position: relative; z-index: 1; width: 100%; min-height: 100vh; display: flex; flex-direction: column; align-items: center; padding: 40px 25px; box-sizing: border-box; }
        .main-container { display: flex; justify-content: center; align-items: stretch; width: 100%; max-width: 1150px; gap: 45px; margin-bottom: 40px; }
        .form-container, .info-container { flex: 1; background: rgba(255, 255, 255, 0.97); backdrop-filter: blur(12px); padding: 35px 40px; border-radius: 16px; box-shadow: 0 15px 45px rgba(0, 0, 0, 0.15); border: 1px solid rgba(255, 255, 255, 0.6); animation: fadeInSlideUp 0.9s ease-out forwards; min-width: 320px; border-top: 6px solid var(--saffron); position: relative; }
        .form-container::before, .info-container::before { content: ''; position: absolute; top: -1px; left: 33.33%; width: 33.33%; height: 6px; background-color: var(--green); z-index: 2; }
        .info-container { animation-delay: 0.2s; display: flex; flex-direction: column; }

        /* --- Title & General Form Styles --- */
        .form-title { color: var(--navy); font-size: 2.1em; font-weight: 600; text-align: center; margin-bottom: 30px; display: flex; align-items: center; justify-content: center; gap: 12px; }
        .title-icon { font-size: 1.1em; color: var(--navy); }
        .input-group { margin-bottom: 22px; }
        label { display: block; margin-bottom: 8px; color: var(--text-light); font-size: 1rem; font-weight: 500; }
        .input-wrapper { position: relative; }
        .input-icon { position: absolute; left: 14px; top: 50%; transform: translateY(-50%); color: #aaa; font-size: 1.1rem; pointer-events: none; transition: color 0.3s ease; z-index: 3; }
        input[type="text"], input[type="email"], input.flatpickr-input {
            width: 100%; padding: 12px 15px 12px 45px;
            border: 1px solid var(--border-color); border-radius: 8px;
            font-size: 1.05rem; transition: border-color 0.3s ease, box-shadow 0.3s ease, background-color 0.3s ease;
            color: var(--text-dark); background-color: rgba(255,255,255,0.95);
        }
        input.flatpickr-input[readonly] {
            background-color: rgba(255,255,255,0.95);
            cursor: pointer;
        }
        input:focus, input.flatpickr-input:focus {
            border-color: var(--border-focus-color);
            box-shadow: 0 0 0 3px rgba(0, 0, 128, 0.15);
            outline: none; background-color: var(--white);
        }
        input:focus + .input-icon, input.flatpickr-input:focus + .input-icon {
            color: var(--border-focus-color);
        }
        input.error, input.flatpickr-input.error { border-color: #e53e3e; background-color: var(--light-red); }
        input.error + .input-icon, input.flatpickr-input.error + .input-icon { color: #e53e3e; }
        input.error:focus, input.flatpickr-input.error:focus { box-shadow: 0 0 0 3px rgba(229, 62, 62, 0.15); border-color: #e53e3e; }

        /* --- CAPTCHA Styles --- */
        .captcha-container { display: flex; align-items: center; gap: 15px; margin-bottom: 20px; flex-wrap: wrap; }
        .captcha-display { font-family: 'Courier New', Courier, monospace; font-size: 1.6rem; font-weight: bold; letter-spacing: 6px; padding: 10px 18px; background-color: #f0f4f8; border: 1px solid #ccc; border-radius: 8px; color: var(--navy); user-select: none; display: inline-flex; align-items: center; text-decoration: line-through wavy rgba(0,0,0,0.15); flex-grow: 1; min-width: 170px; text-align: center; }
        #captcha-text { flex-grow: 1; }
        .refresh-button { background: none; border: none; color: var(--green); font-size: 1.5rem; cursor: pointer; padding: 5px; line-height: 1; transition: transform 0.3s ease; margin-left: 5px; flex-shrink: 0; }
        .refresh-button:hover { transform: rotate(190deg) scale(1.05); }
        .refresh-button:disabled { color: #aaa; cursor: not-allowed; transform: none; }
        .captcha-input-group { flex-grow: 1; min-width: 140px; }
        #captcha_input { padding-left: 15px; text-transform: uppercase; letter-spacing: 2px; font-size: 1.05rem; }

        /* --- Submit Button --- */
        .submit-button { width: 100%; padding: 14px; background: linear-gradient(135deg, var(--green), #107d07); color: white; border: none; border-radius: 10px; font-size: 1.2rem; font-weight: 600; cursor: pointer; transition: all 0.3s ease; box-shadow: 0 5px 15px rgba(19, 136, 8, 0.25); display: flex; align-items: center; justify-content: center; gap: 10px; }
        .submit-button:hover:not(:disabled) { background: linear-gradient(135deg, #107d07, #0b6d05); box-shadow: 0 7px 20px rgba(19, 136, 8, 0.3); transform: translateY(-3px); }
        .submit-button:active:not(:disabled) { transform: translateY(0px); box-shadow: 0 3px 10px rgba(19, 136, 8, 0.2); }
        .submit-button:disabled { background: #bbb; cursor: not-allowed; box-shadow: none; transform: none; opacity: 0.7; }

        /* --- Message Boxes --- */
        .message-box { text-align: center; margin-bottom: 20px; padding: 12px 15px; border-radius: 8px; font-size: 1rem; font-weight: 500; animation: fadeInSlideUp 0.5s ease-out; display: flex; align-items: center; justify-content: center; gap: 8px; }
        .error-message { color: #c53030; background-color: var(--light-red); border: 1px solid #f56565; }
        .success-message { color: #2f855a; background-color: var(--light-green); border: 1px solid #68d391; }
        .success-message i, .error-message i { font-size: 1.1em; }

        /* --- Info Container Styles --- */
        .dynamic-message { font-size: 1.9em; font-weight: 500; color: var(--green); text-align: center; margin-bottom: 30px; min-height: 2.8em; display: flex; align-items: center; justify-content: center; opacity: 1; transition: opacity 0.5s ease-in-out; text-shadow: 1px 1px 2px rgba(0,0,0,0.05); }
        .calendar { background: transparent; padding: 15px 0; }
        .month { color: var(--saffron); font-size: 1.9em; font-weight: 600; text-align: center; margin-bottom: 20px; }
        .dates { display: grid; grid-template-columns: repeat(7, 1fr); gap: 8px; }
        .day-name { font-weight: 600; font-size: 0.9rem; color: var(--text-light); text-align: center; padding-bottom: 8px; text-transform: uppercase; }
        .date { aspect-ratio: 1; display: flex; align-items: center; justify-content: center; font-size: 1.1em; border-radius: 50%; transition: all 0.25s ease; border: 1px solid transparent; cursor: default; color: var(--text-dark); }
        .date:not(.empty):hover { background: var(--light-saffron); color: var(--saffron); transform: scale(1.1); border-color: var(--saffron); }
        .date.today { background: var(--green); color: white; font-weight: bold; border: 2px solid var(--navy); box-shadow: 0 0 12px rgba(19, 136, 8, 0.4); }
        .date.today:hover { background: #0f7007; color: white; border-color: var(--navy); }
        .date.empty { background: transparent; cursor: default; opacity: 0; }
        .indian-flag { display: block; width: 85%; max-width: 280px; margin: 30px auto 0 auto; border-radius: 10px; box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15); animation: pulse 3.5s infinite ease-in-out; border: 1px solid #eee; }
        .made-in-india { text-align: center; margin-top: auto; padding-top: 25px; font-size: 0.95rem; color: var(--text-light); opacity: 0.9; font-weight: 500; }
        .made-in-india img { display: inline-block; height: 1em; margin-left: 5px; vertical-align: middle; }

        /* --- MODERN FLATPICKR STYLES --- */
        .flatpickr-calendar {
            background: var(--white);
            border-radius: 12px;
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.12), 0 3px 10px rgba(0, 0, 0, 0.08);
            border: none;
            font-size: 0.95rem;
            width: 300px;
            padding: 10px;
            z-index: 1000;
        }

        /* Month Navigation */
        .flatpickr-months {
            background: var(--white);
            border-bottom: 1px solid #eee;
            padding: 10px 0;
            display: flex;
            align-items: center;
        }
        .flatpickr-month {
            height: 40px;
            line-height: 40px;
            flex: 1;
        }
        .flatpickr-current-month {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--navy);
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
        }
        .flatpickr-current-month .flatpickr-monthDropdown-months,
        .flatpickr-current-month .numInputWrapper {
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 6px;
            padding: 2px 6px;
            background: var(--light-saffron);
            transition: background-color 0.2s ease;
        }
        .flatpickr-current-month .flatpickr-monthDropdown-months:hover,
        .flatpickr-current-month .numInputWrapper:hover {
            background-color: var(--saffron);
            color: var(--white);
        }
        .flatpickr-prev-month,
        .flatpickr-next-month {
            fill: var(--navy);
            padding: 8px;
            border-radius: 50%;
            width: 32px;
            height: 32px;
            transition: background-color 0.2s ease;
        }
        .flatpickr-prev-month:hover,
        .flatpickr-next-month:hover {
            background-color: var(--light-saffron);
            fill: var(--saffron);
        }

        /* Weekdays */
        .flatpickr-weekdays {
            background: var(--white);
            padding: 6px 0;
            border-bottom: 1px solid #eee;
        }
        .flatpickr-weekday {
            color: var(--navy);
            font-weight: 500;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Days */
        .flatpickr-days {
            padding: 8px;
        }
        .dayContainer {
            padding: 0;
            min-width: 280px;
            max-width: 280px;
        }
        .flatpickr-day {
            border-radius: 6px;
            border: 1px solid transparent;
            line-height: 34px;
            max-width: 34px;
            height: 34px;
            font-weight: 400;
            margin: 2px;
            transition: all 0.2s ease;
            color: var(--text-dark);
        }
        .flatpickr-day:hover {
            background-color: var(--light-saffron);
            border-color: var(--saffron);
            color: var(--saffron);
        }
        .flatpickr-day.today {
            border-color: var(--navy);
            background-color: var(--light-saffron);
            color: var(--navy);
            font-weight: 600;
        }
        .flatpickr-day.today:hover {
            background-color: var(--saffron);
            color: var(--white);
        }
        .flatpickr-day.selected,
        .flatpickr-day.startRange,
        .flatpickr-day.endRange {
            background: var(--green);
            border-color: var(--green);
            color: var(--white);
            font-weight: 500;
        }
        .flatpickr-day.today.selected {
            background: var(--green);
            border-color: var(--navy);
            color: var(--white);
        }
        .flatpickr-day.disabled,
        .flatpickr-day.disabled:hover {
            color: #ccc;
            background: #f9f9f9;
            border-color: transparent;
            cursor: not-allowed;
        }
        .flatpickr-day.prevMonthDay,
        .flatpickr-day.nextMonthDay {
            color: #aaa;
        }
        .flatpickr-day.prevMonthDay:hover,
        .flatpickr-day.nextMonthDay:hover {
            background-color: #f0f0f0;
            color: #888;
        }

        /* Clear Button */
        .flatpickr-clear {
            display: block;
            width: 100%;
            padding: 8px;
            background: var(--light-red);
            color: #e53e3e;
            border: none;
            border-radius: 6px;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            text-align: center;
            margin: 5px auto 0;
            transition: background-color 0.2s ease;
        }
        .flatpickr-clear:hover {
            background: #e53e3e;
            color: var(--white);
        }

        /* --- Placeholder Content --- */
        .placeholder-content { background-color: rgba(255, 255, 255, 0.95); padding: 30px; margin-top: 40px; border-radius: 15px; width: 100%; max-width: 900px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .placeholder-content h2 { font-size: 1.8em; color: var(--navy); margin-bottom: 15px; border-bottom: 2px solid var(--saffron); padding-bottom: 10px; }
        .placeholder-content p { font-size: 1.05rem; line-height: 1.7; color: var(--text-dark); margin-bottom: 15px; }

        /* --- Responsive Design --- */
        @media (max-width: 900px) {
            .main-container { flex-direction: column; align-items: center; gap: 30px; }
            .form-container, .info-container { width: 100%; max-width: 600px; flex: none; animation-delay: 0s !important; }
            .placeholder-content { margin-top: 30px; }
            .ashoka-chakra { --chakra-size: 12vh; --chakra-min-size: 70px; }
        }
        @media (max-width: 500px) {
            html { font-size: 16px; }
            .content-wrapper { padding: 25px 15px; }
            .form-container, .info-container { padding: 25px 20px; }
            .form-title { font-size: 1.9em; }
            .dynamic-message { font-size: 1.6em; }
            .month { font-size: 1.7em; }
            .captcha-display { font-size: 1.4rem; letter-spacing: 4px; padding: 8px 12px; min-width: 150px;}
            .submit-button { font-size: 1.1rem; padding: 12px; }
            .placeholder-content { padding: 20px; }
            .placeholder-content h2 { font-size: 1.6em; }
            .placeholder-content p { font-size: 1rem; }
            .ashoka-chakra { --chakra-size: 10vh; --chakra-min-size: 60px; }
            .captcha-container { flex-direction: column; align-items: stretch; }
            .captcha-display { width: 100%; justify-content: center; }
            .captcha-input-group { width: 100%; }
            .flatpickr-calendar { width: 90vw; max-width: 280px; }
            .dayContainer { min-width: 100%; max-width: 100%; }
            .flatpickr-day { max-width: 32px; height: 32px; line-height: 32px; margin: 1px; }
        }
    </style>
</head>
<body>
    <!-- Animated Flag Background -->
    <div class="animated-flag-background">
        <div class="bg-band bg-saffron"></div>
        <div class="bg-band bg-white"></div>
        <div class="bg-band bg-green"></div>
        <img src="https://upload.wikimedia.org/wikipedia/commons/1/17/Ashoka_Chakra.svg" alt="Ashoka Chakra" class="ashoka-chakra">
    </div>

    <!-- Content Wrapper for Scrolling -->
    <div class="content-wrapper">
        <div class="main-container">
            <!-- Left Column: Login Form -->
            <div class="form-container <?php echo $form_has_error ? 'shake-error' : ''; ?>" id="login-form-container">
                <h2 class="form-title">
                    <i class="fas fa-person-booth title-icon"></i>
                    Voter Login Portal
                </h2>

                <!-- Message Area -->
                <div id="message-area">
                    <?php if (!empty($error_message)): ?>
                        <div class="message-box error-message" role="alert" aria-live="assertive">
                            <i class="fas fa-times-circle"></i> <?php echo htmlspecialchars($error_message); ?>
                        </div>
                    <?php endif; ?>
                    <?php if (!empty($success_message)): ?>
                        <div class="message-box success-message" role="status" aria-live="polite">
                            <i class="fas fa-check-circle"></i> <?php echo htmlspecialchars($success_message); ?>
                        </div>
                    <?php endif; ?>
                </div>

                <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="POST" id="login-form" novalidate>
                    <!-- Input: Full Name -->
                    <div class="input-group">
                        <label for="username">Voter's Full Name</label>
                        <div class="input-wrapper">
                            <input type="text" id="username" name="username" placeholder="Enter name as per official records"
                                   class="<?php echo in_array('username', $invalid_fields) ? 'error' : ''; ?>"
                                   value="<?php echo isset($_POST['username']) ? htmlspecialchars($_POST['username']) : ''; ?>"
                                   required aria-required="true" autocomplete="name"
                                   aria-invalid="<?php echo in_array('username', $invalid_fields) ? 'true' : 'false'; ?>">
                            <i class="fas fa-user input-icon"></i>
                        </div>
                    </div>
                    <!-- Input: Voter ID -->
                    <div class="input-group">
                        <label for="voter_id">Voter ID Number (EPIC)</label>
                        <div class="input-wrapper">
                            <input type="text" id="voter_id" name="voter_id" placeholder="Format: ABC1234567"
                                   pattern="[A-Za-z]{3}[0-9]{7}" maxlength="10"
                                   title="Enter 10 character Voter ID (e.g., ABC1234567)"
                                   class="<?php echo in_array('voter_id', $invalid_fields) ? 'error' : ''; ?>"
                                   value="<?php echo isset($_POST['voter_id']) ? htmlspecialchars($_POST['voter_id']) : ''; ?>"
                                   required aria-required="true" autocomplete="off"
                                   aria-invalid="<?php echo in_array('voter_id', $invalid_fields) ? 'true' : 'false'; ?>">
                            <i class="fas fa-id-card input-icon"></i>
                        </div>
                    </div>
                    <!-- Input: Date of Birth -->
                    <div class="input-group">
                        <label for="dob">Date of Birth <span class="text-xs text-gray-500">(DD-MM-YYYY)</span></label>
                        <div class="input-wrapper">
                            <input type="text" id="dob" name="dob" placeholder="Select Date of Birth"
                                   class="flatpickr flatpickr-input <?php echo in_array('dob', $invalid_fields) ? 'error' : ''; ?>"
                                   value="<?php echo isset($_POST['dob']) ? htmlspecialchars($_POST['dob']) : ''; ?>"
                                   required aria-required="true" autocomplete="bday"
                                   aria-invalid="<?php echo in_array('dob', $invalid_fields) ? 'true' : 'false'; ?>"
                                   aria-describedby="dob-error-message"
                                   >
                            <i class="fas fa-calendar-alt input-icon"></i>
                        </div>
                        <span id="dob-error-message" class="text-xs text-red-600 <?php echo !in_array('dob', $invalid_fields) ? 'hidden' : ''; ?>">
                            <?php if (in_array('dob', $invalid_fields)) echo htmlspecialchars($error_message); ?>
                        </span>
                    </div>
                    <!-- Input: Email -->
                    <div class="input-group">
                        <label for="email">Registered Email Address</label>
                        <div class="input-wrapper">
                            <input type="email" id="email" name="email" placeholder="Enter your linked email"
                                   class="<?php echo in_array('email', $invalid_fields) ? 'error' : ''; ?>"
                                   value="<?php echo isset($_POST['email']) ? htmlspecialchars($_POST['email']) : ''; ?>"
                                   required aria-required="true" autocomplete="email"
                                   aria-invalid="<?php echo in_array('email', $invalid_fields) ? 'true' : 'false'; ?>">
                            <i class="fas fa-envelope input-icon"></i>
                        </div>
                    </div>
                    <!-- Input: CAPTCHA -->
                    <div class="input-group">
                        <label for="captcha_input">Security Verification Code</label>
                        <div class="captcha-container">
                            <div class="captcha-display" id="captcha-display" aria-label="Security code image">
                                <span id="captcha-text"><?php echo htmlspecialchars($_SESSION['captcha'] ?? ''); ?></span>
                                <button type="button" id="refresh_Captcha" class="refresh-button" title="Refresh Code" aria-label="Refresh Security Code">
                                    <i class="fas fa-sync-alt"></i>
                                </button>
                            </div>
                            <div class="input-wrapper captcha-input-group">
                                <input type="text" id="captcha_input" name="captcha" placeholder="Enter Code Above" maxlength="6" autocomplete="off"
                                       class="<?php echo in_array('captcha', $invalid_fields) ? 'error' : ''; ?>"
                                       required aria-required="true"
                                       aria-invalid="<?php echo in_array('captcha', $invalid_fields) ? 'true' : 'false'; ?>"
                                       aria-describedby="captcha-error-message">
                            </div>
                        </div>
                        <span id="captcha-error-message" class="text-xs text-red-600 <?php echo !in_array('captcha', $invalid_fields) ? 'hidden' : ''; ?>">
                            <?php if(in_array('captcha', $invalid_fields) && $error_message === 'Security Code is required.') echo $error_message; ?>
                            <?php if(in_array('captcha', $invalid_fields) && $error_message === 'Invalid Security Code.') echo $error_message; ?>
                        </span>
                    </div>
                    <!-- Submit Button -->
                    <button type="submit" class="submit-button" id="login-button" <?php if(!empty($success_message)) echo 'disabled'; ?>>
                        <span class="button-icon"><i class="fas fa-fingerprint"></i></span>
                        <span class="button-text">Verify & Proceed to Vote</span>
                        <span class="button-spinner hidden"><i class="fas fa-spinner fa-spin"></i> Authenticating...</span>
                    </button>
                    <!-- Footer Text -->
                    <p class="made-in-india">
                        Republic of India - Online Voting Portal
                    </p>
                </form>
            </div>

            <!-- Right Column: Info/Calendar -->
            <div class="info-container">
                <div class="dynamic-message" id="dynamicMessage">Your Vote is Your Power!</div>

                <div class="calendar">
                    <div class="month"><?php echo date('F Y'); ?></div>
                    <div class="dates">
                        <?php
                        $days_of_week = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                        foreach ($days_of_week as $day) { echo "<div class='day-name'>$day</div>"; }
                        $year = date('Y'); $month = date('m');
                        $first_day_of_month = date('w', strtotime("$year-$month-01"));
                        $days_in_month = date('t', strtotime("$year-$month-01"));
                        $current_day = date('j');
                        for ($i = 0; $i < $first_day_of_month; $i++) { echo "<div class='date empty'></div>"; }
                        for ($day = 1; $day <= $days_in_month; $day++) {
                            $class = 'date' . ($day == $current_day ? ' today' : '');
                            echo "<div class='$class'>$day</div>";
                        }
                        $total_cells = $first_day_of_month + $days_in_month;
                        $remaining_cells = (7 - ($total_cells % 7)) % 7;
                        for ($i = 0; $i < $remaining_cells; $i++) { echo "<div class='date empty'></div>"; }
                        ?>
                    </div>
                </div>

                <img src="https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png"
                     alt="Flag of India" class="indian-flag">

                <p class="made-in-india">
                    Official Portal - Election Commission of India
                </p>
            </div>
        </div>

        <!-- Placeholder Content for Scrolling -->
        <main class="placeholder-content">
            <h2>About the Online Voting Portal</h2>
            <p>This platform provides a secure and accessible method for registered voters of the Republic of India to cast their ballots electronically. Our system ensures the integrity of the election process through multi-factor authentication and robust security measures.</p>
            <p>Utilizing modern cryptographic techniques and secure server infrastructure, we aim to uphold the principles of free and fair elections in the digital age. Voter privacy and ballot secrecy are paramount throughout the process.</p>
            <h2>Instructions for Voters</h2>
            <p>1. Fill in your Full Name exactly as it appears on your Voter ID card.</p>
            <p>2. Enter your 10-character Voter ID (EPIC) number in the format ABC1234567.</p>
            <p>3. Select your Date of Birth using the calendar by clicking the input field.</p>
            <p>4. Provide the Email Address linked to your voter registration.</p>
            <p>5. Carefully enter the Security Verification Code shown. Click the refresh icon (<i class="fas fa-sync-alt text-xs"></i>) if needed.</p>
            <p>6. Click "Verify & Proceed to Vote". If verification is successful, you will be redirected to the secure voting page.</p>
            <h2>Importance of Voting</h2>
            <p>Voting is a fundamental right and responsibility in a democracy. Your participation ensures that your voice is heard and contributes to shaping the future of our nation. Every vote counts towards building a stronger India. Exercise your franchise wisely and contribute to the democratic process.</p>
            <p>The Election Commission of India is committed to increasing voter turnout and making the electoral process more inclusive and convenient for all eligible citizens.</p>
        </main>
    </div>

    <!-- Flatpickr JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.13/flatpickr.min.js" integrity="sha512-K/oyQtMXpxI4+K0W7H25UopjM8cOysljSk3NRaJsRPLHzqEXZmSvf2RMEa/0PO9Nlvz/NL8ITrcTFW2E/wVzCA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        'use strict';

        // --- Dynamic Message Rotation ---
        const messages = [ "Your Vote is Your Power!", "Shape India's Destiny", "Empowering Democracy", "Every Citizen's Right, Every Vote Counts", "Secure Digital Voting", "Cast Your Vote Responsibly" ];
        let currentMessageIndex = 0;
        const messageElement = document.getElementById('dynamicMessage');
        if (messageElement) {
            setInterval(() => {
                messageElement.style.opacity = 0;
                setTimeout(() => {
                    currentMessageIndex = (currentMessageIndex + 1) % messages.length;
                    messageElement.textContent = messages[currentMessageIndex];
                    messageElement.style.opacity = 1;
                }, 600);
            }, 5500);
        }

        // --- Flatpickr Initialization ---
        try {
                const dobPicker = flatpickr("#dob", {
                    dateFormat: "Y-m-d",
                    altInput: true,
                    altFormat: "F j, Y",
                    defaultDate: new Date(new Date().setFullYear(new Date().getFullYear() - 18)),
                    maxDate: new Date().fp_incr(-18 * 365.25),
                    minDate: new Date().fp_incr(-100 * 365.25),
                    allowInput: false,
                    disableMobile: false,
                    monthSelectorType: "dropdown",
                    yearSelectorType: "dropdown",
                    appendTo: document.body,
                    theme: "light",
                    errorHandler: (error) => {
                        console.error("Flatpickr Error:", error);
                    },
                    onReady: function(selectedDates, dateStr, instance) {
                        // Add Clear button
                        const clearButton = document.createElement("button");
                        clearButton.className = "flatpickr-clear";
                        clearButton.textContent = "Clear Date";
                        clearButton.type = "button";
                        clearButton.addEventListener("click", () => {
                            instance.clear();
                            const errorSpan = document.getElementById('dob-error-message');
                            if (errorSpan) errorSpan.classList.add('hidden');
                            const dobInput = document.getElementById('dob');
                            if (dobInput) dobInput.classList.remove('error');
                        });
                        instance.calendarContainer.appendChild(clearButton);
                    },
                    onChange: function(selectedDates, dateStr, instance) {
                        // Client-side validation
                        const dobError = document.getElementById('dob-error-message');
                        const dobInput = document.getElementById('dob');
                        if (!selectedDates.length) {
                            dobInput.classList.add('error');
                            dobError.textContent = "Date of Birth is required.";
                            dobError.classList.remove('hidden');
                        } else {
                            const selectedDate = selectedDates[0];
                            const today = new Date();
                            const minDate = new Date(today.setFullYear(today.getFullYear() - 18));
                            const maxDate = new Date(today.setFullYear(today.getFullYear() - 100));
                            if (selectedDate > minDate) {
                                dobInput.classList.add('error');
                                dobError.textContent = "You must be at least 18 years old to vote.";
                                dobError.classList.remove('hidden');
                            } else if (selectedDate < maxDate) {
                                dobInput.classList.add('error');
                                dobError.textContent = "Date of Birth is too far in the past.";
                                dobError.classList.remove('hidden');
                            } else {
                                dobInput.classList.remove('error');
                                dobError.classList.add('hidden');
                            }
                        }
                    }
                });
            } catch (e) {
                console.error("Failed to initialize Flatpickr:", e);
                const dobInput = document.getElementById('dob');
                if (dobInput) dobInput.type = 'date';
            }

        // --- CAPTCHA Refresh Logic ---
        // ***** CORRECTED ID HERE *****
        const refreshButton = document.getElementById('refresh_Captcha');
        const captchaTextElement = document.getElementById('captcha-text');
        const captchaInputElement = document.getElementById('captcha_input');

        if (refreshButton && captchaTextElement) {
            refreshButton.addEventListener('click', function(event) {
                event.preventDefault();
                if (refreshButton.disabled) return; // Prevent multiple rapid clicks
                refreshButton.disabled = true;
                refreshButton.innerHTML = '<i class="fas fa-spinner fa-spin"></i>'; // Loading indicator

                fetch('<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>?refresh_captcha=true', {
                    method: 'GET',
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest', 'Accept': 'application/json',
                        'Cache-Control': 'no-cache, no-store, must-revalidate', 'Pragma': 'no-cache', 'Expires': '0'
                    }
                })
                .then(response => {
                    if (!response.ok) {
                        // Throw an error with status text for better debugging
                        return Promise.reject(`HTTP error ${response.status}: ${response.statusText}`);
                    }
                    return response.json();
                })
                .then(data => {
                    if (data && data.captcha) {
                        captchaTextElement.textContent = data.captcha;
                        // Clear input field and any error state
                        if(captchaInputElement) {
                            captchaInputElement.value = '';
                            captchaInputElement.classList.remove('error');
                            const errorSpan = document.getElementById('captcha-error-message');
                            if(errorSpan) errorSpan.classList.add('hidden');
                        }
                    } else {
                        // Throw specific error if data format is wrong
                        throw new Error('Invalid CAPTCHA data received from server');
                    }
                })
                .catch(error => {
                    // Log the detailed error and show a user-friendly message
                    console.error('Error refreshing CAPTCHA:', error);
                    captchaTextElement.textContent = 'Error';
                    // Optionally show an alert or message to the user
                    // alert('Failed to refresh the security code. Please try again.');
                })
                .finally(() => {
                    // Ensure button is re-enabled after fetch completes (success or failure)
                    setTimeout(() => {
                        refreshButton.innerHTML = '<i class="fas fa-sync-alt"></i>'; // Restore icon
                        refreshButton.disabled = false;
                    }, 300); // Small delay
                });
            });
        } else {
            console.warn("CAPTCHA refresh button or text element not found.");
        }

        // --- Form Submission Handling ---
        const loginForm = document.getElementById('login-form');
        const loginButton = document.getElementById('login-button');
        const successMessageElement = document.querySelector('.success-message');

        if (loginForm && loginButton) {
            loginForm.addEventListener('submit', function(e) {
                // Check browser validation first
                if (!loginForm.checkValidity()) {
                    // Browser will handle showing default validation errors
                    return;
                }
                // Only show spinner if there isn't already a success message visible
                if (!document.querySelector('.success-message')) {
                    loginButton.disabled = true;
                    loginButton.querySelector('.button-text').classList.add('hidden');
                    loginButton.querySelector('.button-icon').classList.add('hidden');
                    loginButton.querySelector('.button-spinner').classList.remove('hidden');
                }
            });
        }

        // --- Redirect on Success ---
        if (successMessageElement) {
            console.log("Success message found, redirecting in 2.5 seconds...");
            setTimeout(() => { window.location.href = "voting.php"; }, 2500);
        }

        // --- Remove Shake Animation ---
        const formContainer = document.getElementById('login-form-container');
        if (formContainer && formContainer.classList.contains('shake-error')) {
            formContainer.addEventListener('animationend', () => {
                formContainer.classList.remove('shake-error');
            }, { once: true });
        }
    }); // End DOMContentLoaded
</script>
</body>
</html>