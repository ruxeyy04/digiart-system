<?php
include('../config.php');

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['uname'];
    $firstname = $_POST['fname'];
    $lastname = $_POST['lname'];
    $contact_number = $_POST['phone'];
    $country = $_POST['country'];
    $gender = $_POST['gender'];
    $email = $_POST['emal'];
    $password = $_POST['password'];
    $status = 'registered';
    $usertype = 'client';

    // Generate User_ID
    $date = date('ymd');
    $random_numbers = str_pad(rand(0, 999), 3, '0', STR_PAD_LEFT);
    $user_id = $date . $random_numbers;


    $stmt = $conn->prepare("INSERT INTO users (User_ID, Usertype, Username, Firstname, Lastname, Contact_number, Country, Gender, Email, Password, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sssssssssss", $user_id, $usertype, $username, $firstname, $lastname, $contact_number, $country, $gender, $email, $password, $status);

    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Database insertion failed: ' . $stmt->error]);
    }

    $stmt->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
}

$conn->close();
?>
