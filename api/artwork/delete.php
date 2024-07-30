<?php

include('../config.php');
if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    $putData = file_get_contents("php://input");

    $formData = parse_multipart_formdata($putData);
    $artworkId = $formData['artworkid'] ?? '';
    $stmt = $conn->prepare("DELETE FROM art WHERE Artwork_ID = ?");
    $stmt->bind_param("i", $artworkId);
        // Set the directory where images are stored
        $image = $artworkId . '.JPG';
        $target_dir = "../../arts/";
        $target_file = $target_dir . $image;

        // Delete the image file
        if (file_exists($target_file)) {
            unlink($target_file);
        } 
    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to delete artwork']);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
}
?>
