<?php
include('../config.php');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $stmt = $conn->prepare("SELECT User_ID, Usertype, Password FROM users WHERE Username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        
        if ($password == $user['Password']) {  // Simple password check, not recommended for production
            echo json_encode([
                'success' => true,
                'userid' => $user['User_ID'],
                'usertype' => $user['Usertype']
            ]);
        } else {
            echo json_encode([
                'success' => false,
                'message' => 'Invalid password.'
            ]);
        }
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Invalid username.'
        ]);
    }

    $stmt->close();
}

$conn->close();
?>
