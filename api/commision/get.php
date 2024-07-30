<?php
include('../config.php');

$response = array();

$user_id = $_GET['userid'] ?? exit(json_encode(['error' => 'User ID not provided.'])); 
$status = $_GET["status"] ?? null; // Get status from the request if it exists
$sql = "SELECT c.*, u.Firstname, u.Lastname, b.Firstname AS cFname, b.Lastname AS cLname 
FROM commission c INNER JOIN users u ON c.artist_id = u.User_ID RIGHT JOIN users b ON c.User_ID = b.User_ID 
WHERE c.artist_id = ?";

// Check if a status is provided and build the SQL query accordingly
if ($status) {
    if ($status == "Paid") {
        $sql .= " AND c.paid = '$status'";
    } else {
        $sql .= " AND c.status ='$status'";
    }
}
$sql .= " ORDER BY FIELD(c.status, 'Pending', 'Accepted', 'In Progress','Completed', 'Rejected', 'Cancelled') asc";

$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $user_id);
$stmt->execute();
$result = $stmt->get_result();
$commissions = array();

while ($row = $result->fetch_assoc()) {
    $commissions[] = $row;
}

$response['data'] = $commissions;

header('Content-Type: application/json');
echo json_encode($response);

$stmt->close();
$conn->close();
?>
