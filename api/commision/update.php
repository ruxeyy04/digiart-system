<?php 
include('../config.php');

if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    // Get PUT data
    $putData = file_get_contents("php://input");
    $formData = parse_multipart_formdata($putData);

    // Extract form fields
    $commi_id = $formData['commi_id'] ?? '';
    $artstyle = $formData['artstyle'] ?? '';
    $deadline = $formData['deadline'] ?? '';
    $message = $formData['message'] ?? '';

    // Update commission in database (Replace placeholders with actual update logic)
    $stmt = $conn->prepare("UPDATE commission SET Artstyle = ?, deadline = ?, message = ? WHERE Commission_ID = ?");
    $stmt->bind_param("sssi", $artstyle, $deadline, $message, $commi_id);
    
    if ($stmt->execute()) {
        $response = ['success' => true, 'message' => 'Commission updated successfully'];
    } else {
        $response = ['success' => false, 'message' => 'Failed to update commission'];
    }

    $stmt->close();
} else {
    $response = ['success' => false, 'message' => 'Invalid request method'];
}

header('Content-Type: application/json');
echo json_encode($response);
$conn->close();
?>