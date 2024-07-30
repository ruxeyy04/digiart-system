<?php
include('../config.php');

$response = array();

$user_id = $_GET['userid'] ?? exit(json_encode(['error' => 'User ID not provided.']));
$status = $_GET["status"] ?? null; // Get status from the request if it exists

// Base SQL query
$sql = "SELECT c.*, u.Firstname, u.Lastname 
        FROM commission c 
        INNER JOIN users u ON c.artist_id = u.User_ID 
        WHERE c.User_ID = ?";

// Check if a status is provided and build the SQL query accordingly
if ($status) {
    if ($status == "Paid") {
        $sql .= " AND c.paid = ?";
    } else {
        $sql .= " AND c.status = ?";
    }
}

// Add ORDER BY clause
$sql .= " ORDER BY FIELD(c.status, 'Pending', 'Accepted', 'In Progress', 'Completed', 'Rejected', 'Cancelled') ASC";

// Prepare the statement
$stmt = $conn->prepare($sql);

// Bind parameters based on whether a status is provided
if ($status) {
    $stmt->bind_param("ss", $user_id, $status);
} else {
    $stmt->bind_param("s", $user_id);
}

// Execute the statement
$stmt->execute();
$result = $stmt->get_result();
$commissions = array();

// Fetch the results
while ($row = $result->fetch_assoc()) {
    $commissions[] = $row;
}

$response['data'] = $commissions;

// Set the response header and output the JSON response
header('Content-Type: application/json');
echo json_encode($response);

// Close the statement and connection
$stmt->close();
$conn->close();
?>
