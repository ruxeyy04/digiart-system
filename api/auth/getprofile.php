<?php
include('../config.php');

$response = array();

$user_id = $_GET['userid'] ?? exit(json_encode(['error' => 'User ID not provided.'])); 

$user_stmt = $conn->prepare("SELECT Username, Firstname, Lastname, Contact_number, Country, Gender, Email FROM users WHERE User_ID = ?");
$user_stmt->bind_param("s", $user_id);
$user_stmt->execute();
$user_result = $user_stmt->get_result();
$user_info = $user_result->fetch_assoc();
$user_stmt->close();

// Check if user info is found
if (!$user_info) {
    $response['error'] = 'User not found.';
    header('Content-Type: application/json');
    echo json_encode($response);
    $conn->close();
    exit;
}

$response['userinfo'] = $user_info;

header('Content-Type: application/json');
echo json_encode($response);

$conn->close();
?>
