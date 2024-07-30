<?php
include('../config.php');

if ($_SERVER['REQUEST_METHOD'] === 'PUT') {

    $putData = file_get_contents("php://input");

    $formData = parse_multipart_formdata($putData);

    $response = [];

    $userId = $formData['User_ID'] ?? '';
    $username = $formData['Username'] ?? '';
    $firstname = $formData['Firstname'] ?? '';
    $lastname = $formData['Lastname'] ?? '';
    $contact_number = $formData['Contact_number'] ?? '';
    $country = $formData['Country'] ?? '';
    $gender = $formData['Gender'] ?? '';
    $email = $formData['Email'] ?? '';
    $newPassword = $formData['newpassword'] ?? '';
    $file = $formData['fileToUpload'];
    if (isset($formData['fileToUpload']) && $file['name'] != null) {

        $response['Uploaded file name'] = $file['name'];
        $response['Uploaded file type'] = $file['type'];

        $fileContentBase64 = base64_encode(file_get_contents($file['tmp_name']));

        $uploadDirectory = realpath(__DIR__ . "/../../profile/") . DIRECTORY_SEPARATOR;
        $destination = $uploadDirectory . $userId . '.JPG';

        $decodedContent = base64_decode($fileContentBase64);
        if (file_put_contents($destination, $decodedContent)) {
            $response['file_upload_status'] = "success";
            $response['file_destination'] = $destination;
        } else {
            $response['file_upload_status'] = "error";
        }
    }

    // Construct SQL query
    $sql = "UPDATE users SET Username=?, Firstname=?, Lastname=?, Contact_number=?, Country=?, Gender=?, Email=?";
    $params = array($username, $firstname, $lastname, $contact_number, $country, $gender, $email);

    if (!empty($newPassword)) {
        $sql .= ", Password=?";
        $params[] = $newPassword; 
    }

    $sql .= " WHERE User_ID=?";
    $params[] = $userId;

    $stmt = $conn->prepare($sql);
    $types = str_repeat('s', count($params) - 1) . 's'; 
    $stmt->bind_param($types, ...$params); 

    if ($stmt->execute()) {
        $response['success'] = true;
    } else {
        $response['success'] = false;
        $response['message'] = 'Failed to update artist information';
    }

    $stmt->close();

    header('Content-Type: application/json');
    echo json_encode($response);
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
}

$conn->close();
?>

