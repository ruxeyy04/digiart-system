<?php
include('../config.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['Username'];
    $firstname = $_POST['Firstname'];
    $lastname = $_POST['Lastname'];
    $contact_number = $_POST['Contact_number'];
    $country = $_POST['Country'];
    $gender = $_POST['Gender'];
    $email = $_POST['Email'];
    $password = $_POST['Password'];
    $status = 'registered';
    $usertype = $_POST['usertype'];

    $date = date('ymd');
    $random_numbers = str_pad(rand(0, 999), 3, '0', STR_PAD_LEFT);
    $user_id = $date . $random_numbers;

    $photo = null; // Initialize photo as null

    if (isset($_FILES['fileToUpload']) && $_FILES['fileToUpload']['tmp_name'] != '') {
        $target_dir = "../../profile/";
        $target_file = $target_dir . $user_id . '.JPG';
        if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
            $photo = $target_file;
        } else {
            echo json_encode(['success' => false, 'message' => 'File upload failed']);
            exit();
        }
    }

    $stmt = $conn->prepare("INSERT INTO users (User_ID, Usertype, Username, Firstname, Lastname, Contact_number, Country, Gender, Email, Password, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sssssssssss", $user_id, $usertype, $username, $firstname, $lastname, $contact_number, $country, $gender, $email, $password, $status);

    if ($stmt->execute()) {
        if ($photo) {
            echo json_encode(['success' => true, 'message' => 'User created with photo']);
        } else {
            echo json_encode(['success' => true, 'message' => 'User created without photo']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'Database insertion failed: ' . $stmt->error]);
    }

    $stmt->close();
}

$conn->close();
?>
