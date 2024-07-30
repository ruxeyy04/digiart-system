<?php

include('../config.php');
if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    $putData = file_get_contents("php://input");

    $formData = parse_multipart_formdata($putData);
    $userid = $formData['userid'] ?? '';
    $stmt = $conn->prepare("DELETE FROM users WHERE User_ID = ?");
    $stmt->bind_param("i", $userid);

    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to delete user']);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
}
?>
