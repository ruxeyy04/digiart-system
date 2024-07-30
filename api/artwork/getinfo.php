<?php
include('../config.php');

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['art_id'])) {
    $art_id = $_GET['art_id'];

    $stmt = $conn->prepare("SELECT * FROM art WHERE Artwork_ID = ?");
    $stmt->bind_param("i", $art_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $artwork = $result->fetch_assoc();
        echo json_encode(['success' => true, 'data' => $artwork]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Artwork not found']);
    }

    $stmt->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request']);
}

$conn->close();
?>
