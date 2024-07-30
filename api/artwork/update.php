<?php
include('../config.php');

if ($_SERVER['REQUEST_METHOD'] === 'PUT') {

    $putData = file_get_contents("php://input");

    $formData = parse_multipart_formdata($putData);

    $response = [];

    $art_id = $formData['art_id'] ?? '';
    $artstyle = $formData['artstyle'] ?? '';
    $date_posted = $formData['date_posted'] ?? '';
    $price = $formData['price'] ?? '';
    $artist_id = $formData['artist_id'] ?? '';
    $file = $formData['fileToUpload'];
    if (isset($formData['fileToUpload']) && $file['name'] != null && $file['name'] != 'empty.jpg') {

        $response['Uploaded file name'] = $file['name'];
        $response['Uploaded file type'] = $file['type'];

        $fileContentBase64 = base64_encode(file_get_contents($file['tmp_name']));

        $uploadDirectory = realpath(__DIR__ . "/../../arts/") . DIRECTORY_SEPARATOR;
        $destination = $uploadDirectory . $art_id . '.JPG';

        $decodedContent = base64_decode($fileContentBase64);
        if (file_put_contents($destination, $decodedContent)) {
            $response['file_upload_status'] = "success";
            $response['file_destination'] = $destination;
        } else {
            $response['file_upload_status'] = "error";
        }
    }

    // Construct SQL query
    $sql = "UPDATE art SET Artstyle=?, Date_posted=?, Price=?";
    $params = array($artstyle, $date_posted, $price);
    
    if (!empty($artist_id)) {
        $sql .= ", User_ID=?";
        $params[] = $artist_id;
    }


    $sql .= " WHERE Artwork_ID=?";
    $params[] = $art_id;

    $stmt = $conn->prepare($sql);
    $types = str_repeat('s', count($params) - 1) . 's'; 
    $stmt->bind_param($types, ...$params); 

    if ($stmt->execute()) {
        $response['success'] = true;
    } else {
        $response['success'] = false;
        $response['message'] = 'Failed to artwork artist information';
    }

    $stmt->close();

    header('Content-Type: application/json');
    echo json_encode($response);
} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request method']);
}

$conn->close();
?>

