<?php
include('../config.php');

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $userId = $_GET['userid'];
    $artistid = $_GET['artistid'];

    // Fetch artist information from the database
    $stmt = $conn->prepare("SELECT COUNT(a.Commission_ID) AS number, b.*
                            FROM commission AS a
                            LEFT JOIN ratings AS b ON b.artistid=a.artist_id
                            WHERE a.User_ID = ? AND a.artist_id = ?");
    $stmt->bind_param("ii", $userId, $artistid);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $artistInfo = $result->fetch_assoc();
        echo json_encode(array("data" => $artistInfo));
    } else {
        echo json_encode(array('error' => 'User not found'));
    }

    $stmt->close();
}

$conn->close();
?>
