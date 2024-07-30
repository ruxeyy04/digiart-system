<?php
include('../config.php');

$response = array();

$commid = $_POST['commid'] ?? exit(json_encode(['error' => 'Commission ID not provided.']));

// Prepare and execute the SQL query to update the status of the commission
$stmt = $conn->prepare("UPDATE commission SET status = 'Cancelled' WHERE Commission_ID = ?");
$stmt->bind_param("s", $commid);

if ($stmt->execute()) {
    $response['success'] = true;
    $response['message'] = 'Commission cancelled successfully.';
} else {
    $response['success'] = false;
    $response['message'] = 'Failed to cancel commission. Please try again later.';
}

$stmt->close();
$conn->close();

header('Content-Type: application/json');
echo json_encode($response);
?>
