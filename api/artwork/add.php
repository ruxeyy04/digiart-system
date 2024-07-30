<?php
include('../config.php');

// Check if form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Retrieve form data
    $userid = $_POST['userid'] ?? '';
    $artstyle = $_POST['artstyle'] ?? '';
    $date_posted = $_POST['date_posted'] ?? '';
    $price = $_POST['price'] ?? '';

    // Attempt to insert artwork into database
    $stmt = $conn->prepare("INSERT INTO art (User_ID, Artstyle, Date_posted, Price) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $userid, $artstyle, $date_posted, $price);

    if ($stmt->execute()) {
        // Insert successful, get the last inserted ID
        $last_insert_id = $stmt->insert_id;
        $stmt->close();

        // File upload
        $target_dir = "../../arts/";
        $file_basename = basename($_FILES["fileToUpload"]["name"]);
        $file_extension = strtolower(pathinfo($file_basename, PATHINFO_EXTENSION));
        $new_filename = $last_insert_id . "." . "JPG";
        $target_file = $target_dir . $new_filename;

        // Check if image file is a valid image
        $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
        if ($check !== false) {
            // Attempt to move uploaded file
            if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
                // File uploaded successfully
                echo json_encode(["success" => true]);
            } else {
                // File upload failed
                echo json_encode(["success" => false, "message" => "Sorry, there was an error uploading your file."]);
            }
        } else {
            // Not a valid image file
            echo json_encode(["success" => false, "message" => "File is not an image."]);
        }
    } else {
        // Insert failed
        echo json_encode(["success" => false, "message" => "Error inserting artwork into database."]);
    }
} else {
    // If not a POST request, return error
    echo json_encode(["success" => false, "message" => "Invalid request method."]);
}

// Close connection
$conn->close();
?>
