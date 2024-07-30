<?php
include('../config.php');

if (isset($_GET['userid'])) {
    $user_id = $_GET['userid'];
    $stmt = $conn->prepare("SELECT art.*, users.Firstname AS Artist_Firstname, users.Lastname AS Artist_Lastname , users.username AS Artist_Username
                            FROM art 
                            INNER JOIN users ON art.User_ID = users.User_ID
                            WHERE art.User_ID = ?");
    $stmt->bind_param("s", $user_id);
} else {
    $stmt = $conn->prepare("SELECT art.*, users.Firstname AS Artist_Firstname, users.Lastname AS Artist_Lastname , users.username AS Artist_Username
                            FROM art 
                            INNER JOIN users ON art.User_ID = users.User_ID");
}

$stmt->execute();
$artworks = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
$stmt->close();

header('Content-Type: application/json');
echo json_encode($artworks);

$conn->close();
