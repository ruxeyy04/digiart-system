<?php
include('../config.php');
$response = array("data" => array());

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $userId = $_GET['userid'];
    $artistid = $_GET['artistid'];

    // Fetch artist information from the database
    $stmt = $conn->prepare("SELECT a.Commission_ID as commID, a.*, b.*
                            FROM commission AS a
                            LEFT JOIN ratings AS b ON b.Commission_ID=a.Commission_ID
                            WHERE a.User_ID = ? 
                            AND a.artist_id = ? 
                            AND a.status = 'Completed'
                            AND b.ratingid IS NULL
                            GROUP BY(commID)");
    $stmt->bind_param("ii", $userId, $artistid);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $response["data"][] = $row;
        }
    } else {
        $response["data"] = 0;
    }  

    echo json_encode($response);

    $stmt->close();
}

$conn->close();