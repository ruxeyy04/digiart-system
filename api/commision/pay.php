<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header('Access-Control-Allow-Methods: POST, GET, PUT, OPTIONS, DELETE');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With');


include('../config.php');

if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
      if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
  }
    // Get PUT data
    $putData = file_get_contents("php://input");
    $formData = parse_multipart_formdata($putData);

    $commi_id = $formData['commi_id'] ?? '';

    // Update commission 'paid' attribute to "Paid" in the database
    $stmt = $conn->prepare("UPDATE commission SET paid = 'Paid' WHERE Commission_ID = ?");
    $stmt->bind_param("i", $commi_id);

    if ($stmt->execute()) {
        $response = ['success' => true, 'message' => 'Commission marked as paid successfully'];
    } else {
        $response = ['success' => false, 'message' => 'Failed to mark the commission as paid'];
    }

    $stmt->close();
} else {
    $response = ['success' => false, 'message' => 'Invalid request method'];
}

header('Content-Type: application/json');
echo json_encode($response);
$conn->close();
?>
