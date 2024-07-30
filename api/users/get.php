<?php
include('../config.php');

header('Content-Type: application/json');

$query = "SELECT User_ID, Username, Firstname, Lastname, Contact_number, Country, Gender, Email, status, Usertype 
          FROM users 
          WHERE Usertype IN ('client', 'admin')";
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
        'Usertype' => $row['Usertype'],
        'status' => $row['status'],
    ];
}

echo json_encode(['data' => $artists]);

$conn->close();
?>
