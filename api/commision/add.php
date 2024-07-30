<?php

include('../config.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $userid = $_POST['userid'];
    $artstyle = $_POST['artstyle'];
    $deadline = $_POST['deadline'];
    $message = $_POST['message'];
    $artistid = $_POST['artist_id'];
    $status = 'Pending';
    $date_commissioned = date('Y-m-d');

    $sql = "INSERT INTO commission (User_ID, Artstyle, deadline, message, status, date_commissioned, artist_id) VALUES (?, ?, ?, ?, ?, ?, ?)";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("issssss", $userid, $artstyle, $deadline, $message, $status, $date_commissioned, $artistid);

    if ($stmt->execute()) {
        echo json_encode(array("success" => true));
    } else {
        echo json_encode(array("success" => false, "message" => "Error: " . $sql . "<br>" . $conn->error));
    }

    $stmt->close();
    $conn->close();
}
