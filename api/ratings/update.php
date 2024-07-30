<?php 
include('../config.php');

if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    // Get PUT data
    $putData = file_get_contents("php://input");
    $formData = parse_multipart_formdata($putData);

    // Extract form fields
    $rating = $formData['rating'] ?? '';
    $comments = $formData['comments'] ?? '';
    $ratingid = $formData['ratingid'] ?? '';

    // Update commission in database (Replace placeholders with actual update logic)
    $stmt = $conn->prepare("UPDATE ratings SET rating = ?, comment = ? WHERE ratingid = ?");
    $stmt->bind_param("isi", $rating, $comments, $ratingid);
    
    if ($stmt->execute()) {
        $response = ['success' => true, 'message' => 'Rating updated successfully'];
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