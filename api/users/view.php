<?php
include('../config.php');

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $userId = $_GET['userid'];

    // Fetch artist information from the database
    $stmt = $conn->prepare("SELECT * FROM users WHERE User_ID = ?");
    $stmt->bind_param("s", $userId);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $artistInfo = $result->fetch_assoc();
        echo json_encode($artistInfo);
    } else {
        echo json_encode(array('error' => 'User not found'));
    }

    $stmt->close();
}

$conn->close();
?>
