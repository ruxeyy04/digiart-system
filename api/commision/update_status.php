<?php
include('../config.php');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $commi_id = $_POST['commi_id'] ?? '';
    $status = $_POST['status'] ?? '';
    $price = $_POST['price'] ?? null;

    if (empty($commi_id) || empty($status)) {
        echo json_encode(['success' => false, 'message' => 'Commission ID and status are required']);
        exit;
    }

    $sql = "UPDATE commission SET status = ?";

    // Append price update only if provided
    if ($status === 'Accepted' && !empty($price)) {
        $sql .= ", commi_price = ?";
    }

    $sql .= " WHERE Commission_ID = ?";

    $stmt = $conn->prepare($sql);
    
    if ($status === 'Accepted' && !empty($price)) {
        $stmt->bind_param("sdi", $status, $price, $commi_id);
    } else {
        $stmt->bind_param("si", $status, $commi_id);
    }

    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Commission status updated successfully']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Failed to update commission status']);
    }

    $stmt->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
}

$conn->close();
?>
