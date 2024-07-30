<?php
include('../config.php');

header('Content-Type: application/json');

$query = "SELECT User_ID, Username, Firstname, Lastname, Contact_number, Country, Gender, Email, status FROM users WHERE Usertype = 'artist'";
$result = $conn->query($query);

$artists = [];

while ($row = $result->fetch_assoc()) {
    $artists[] = [
        'User_ID' => $row['User_ID'],
        'Username' => $row['Username'],
        'Firstname' => $row['Firstname'],
        'Lastname' => $row['Lastname'],
        'Contact_number' => $row['Contact_number'],
        'Country' => $row['Country'],
        'Gender' => $row['Gender'],
        'Email' => $row['Email'],
        'status' => $row['status'],
        'photo' => '../profile/' . $row['User_ID'] . '.JPG', // Assuming the photo name is User_ID.JPG
    ];
}

echo json_encode(['data' => $artists]);

$conn->close();
?>
