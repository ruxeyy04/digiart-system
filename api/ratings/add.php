<?php
include('../config.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $artist_id = $_POST['artist_id'];
    $rating = $_POST['rating'];
    $comments = $_POST['comments'];
    $userid = $_POST['userid'];
    $artwork = $_POST['artwork'];
    
    $sql = "INSERT INTO ratings (userid, artistid, Commission_ID, rating, comment) VALUES (?, ?, ?, ?, ?)";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iiiis", $userid, $artist_id, $artwork, $rating, $comments);

    if ($stmt->execute()) {
        echo json_encode(array("success" => true));
    } else {
        echo json_encode(array("success" => false, "message" => "Error: " . $sql . "<br>" . $conn->error));
    }

    $stmt->close();
    $conn->close();
}
