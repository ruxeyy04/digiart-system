<?php
include('../config.php');

$response = array();

$user_id = $_GET['userid'] ?? exit(json_encode(['error' => 'User ID not provided.'])); 

$user_stmt = $conn->prepare("SELECT a.*, ROUND(COALESCE(AVG(b.rating), 0), 2) AS averagerating
                            FROM users AS a
                            LEFT JOIN ratings AS b ON b.artistid = a.User_ID
                            WHERE a.User_ID = ?");
$user_stmt->bind_param("s", $user_id);
$user_stmt->execute();
$user_result = $user_stmt->get_result();
$user_info = $user_result->fetch_assoc();
$user_stmt->close();

if (!$user_info) {
    $response['error'] = 'User not found.';
    header('Content-Type: application/json');
    echo json_encode($response);
    $conn->close();
    exit;
}

$user_info['photo'] = '../profile/' . $user_id . '.JPG';
$response['userinfo'] = $user_info;

$art_stmt = $conn->prepare("SELECT * FROM art WHERE User_ID = ?");
$art_stmt->bind_param("s", $user_id);
$art_stmt->execute();
$art_result = $art_stmt->get_result();
$artworks = array();

while ($row = $art_result->fetch_assoc()) {
    $row['photo'] = '../arts/' . $row['Artwork_ID'] . '.JPG';
    $artworks[] = $row;
}

$art_stmt->close();
$response['artworks'] = $artworks;

header('Content-Type: application/json');
echo json_encode($response);

$conn->close();
?>
