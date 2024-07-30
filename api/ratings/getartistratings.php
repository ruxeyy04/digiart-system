<?php
include('../config.php');
$response = array("data" => array());

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $artistid = $_GET['artistid'];

    $stmt = $conn->prepare("SELECT a.*, b.*, CONCAT(c.Firstname,' ',c.Lastname) AS client
                            FROM commission AS a
                            INNER JOIN ratings AS b ON a.Commission_ID=b.Commission_ID
                            INNER JOIN users AS c ON b.userid=c.User_ID
                            WHERE a.artist_id = ?");
    $stmt->bind_param("i", $artistid);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows > 0) {
        $stmt1 = $conn->prepare("SELECT ROUND(AVG(a.rating), 2) AS totalrating
                FROM ratings AS a
                WHERE a.artistid = ?");
        $stmt1->bind_param("i", $artistid);
        $stmt1->execute();
        $result1 = $stmt1->get_result();
        $artistInfo = $result1->fetch_assoc();
        $response["totalrating"] = $artistInfo["totalrating"];
        
        while ($row = $result->fetch_assoc()) {
            $row["date_commissioned"] = date("M d, Y", strtotime($row["date_commissioned"]));
            $response["data"][] = $row;
        }
    } else {
        $response["data"] = 0;
    }  

    echo json_encode($response);

    $stmt->close();
}

$conn->close();