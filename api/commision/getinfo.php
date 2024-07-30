<?php
include('../config.php');

$response = array();

$commid = $_GET['commid'] ?? exit(json_encode(['error' => 'Commission ID not provided.']));

// Fetch commission information based on commid
$stmt = $conn->prepare("SELECT * FROM commission WHERE Commission_ID = ?");
$stmt->bind_param("s", $commid);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    // Commission found, retrieve data
    $row = $result->fetch_assoc();
    $response['commi_id'] = $row['Commission_ID'];
    $response['artstyle'] = $row['Artstyle'];
    $response['deadline'] = $row['deadline'];
    $response['message'] = $row['message'];
} else {
    // Commission not found
    exit(json_encode(['error' => 'Commission not found.']));
}

$stmt->close();
$conn->close();

header('Content-Type: application/json');
echo json_encode($response);
?>
