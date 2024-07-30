var userTable = $("#users").DataTable({
  ajax: {
    url: url + "api/users/get",
    dataSrc: "data",
  },
  columns: [
    { data: "User_ID" },
    { data: "Username" },
    { data: "Firstname" },
    { data: "Lastname" },
    { data: "Contact_number" },
    { data: "Gender" },
    { data: "Email" },
    {
      data: "User_ID",
      render: function (data, type, row) {
        return `
            <div class="btn-group">
              <button class="btn btn-danger delete-user" data-userid="${data}">Delete</button>
              <button class="btn btn-warning edit" data-artistid="${data}">Edit</button>
            </div>
          `;
      },
    },
  ],
});

$("#addUserForm").on("submit", function (event) {
  event.preventDefault();
  var formData = new FormData(this);

  $.ajax({
    url: url + "api/users/add",
    type: "POST",
    data: formData,
    processData: false,
    contentType: false,
    success: function (response) {
      var result = JSON.parse(response);
      if (result.success) {
        Swal.fire({
          icon: "success",
          title: "Success",
          text: "User added successfully!",
        }).then(function () {
          $("#addUserModal").modal("hide");
          $("#addUserForm")[0].reset();
          userTable.ajax.reload();
        });
      } else {
        Swal.fire({
          icon: "error",
          title: "Error",
          text: "Failed to add user. " + result.message,
        });
      }
    },
    error: function () {
      Swal.fire({
        icon: "error",
        title: "Error",
        text: "An error occurred while adding the user.",
      });
    },
  });
});

$(document).on("click", ".edit", function () {
  let userId = $(this).data("artistid");
  $.ajax({
    type: "GET",
    url: url + "api/users/view",
    data: { userid: userId },
    dataType: "json",
    success: function (res) {
      console.log(res);
      // Populate the form fields with artist information
      $("#editUserModal").modal("show");
      $('#editUserForm input[name="User_ID"]').val(res.User_ID);
      $('#editUserForm input[name="Username"]').val(res.Username);
      $('#editUserForm input[name="Firstname"]').val(res.Firstname);
      $('#editUserForm input[name="Lastname"]').val(res.Lastname);
      $('#editUserForm input[name="Contact_number"]').val(res.Contact_number);
      $('#editUserForm input[name="Country"]').val(res.Country);
      $('#editUserForm select[name="Gender"]').val(res.Gender);
      $('#editUserForm input[name="Email"]').val(res.Email);
      $('#editUserForm input[name="usertype"]').val(res.Usertype);
    },
    error: function () {
      console.log("Error fetching artist information.");
    },
  });
});

$(document).on("submit", "#editUserForm", function (event) {
  event.preventDefault();

  var formData = new FormData(this);

  $.ajax({
    url: url + "api/users/update",
    type: "PUT",
    data: formData,
    contentType: false,
    processData: false,
    success: function (response) {
      if (response.success) {
        Swal.fire({
          icon: "success",
          title: "Success",
          text: "User updated successfully!",
        }).then(function () {
          // Close the modal
          $("#editUserModal").modal("hide");
          // Reset form
          $("#editUserForm")[0].reset();
          // Reload DataTable
          userTable.ajax.reload();
        });
      } else {
        Swal.fire({
          icon: "error",
          title: "Error",
          text: "Failed to update user. " + response.message,
        });
      }
    },
    error: function () {
      // Show error message with SweetAlert for AJAX errors
      Swal.fire({
        icon: "error",
        title: "Error",
        text: "An error occurred while updating the user. Please try again later.",
      });
    },
  });
});


$(document).on("click", ".delete-user", function () {
  let id = $(this).data("userid");
  $('#deleteUserForm input[name="userid"]').val(id);
  $("#userid").html(id);
  $("#deleteUser").modal("show");
});

$(document).on("submit", "#deleteUserForm", function (event) {
  event.preventDefault();
  var formData = new FormData(this);

  $.ajax({
    type: "DELETE",
    url: url + "api/users/delete",
    data: formData,
    dataType: "json",
    contentType: false,
    processData: false,
    success: function (res) {
      if (res.success) {
        Swal.fire({
          icon: "success",
          title: "Success",
          text: "User deleted successfully!",
        }).then(function () {
          userTable.ajax.reload();
          $("#deleteUser").modal("hide");
        });
      } else {
        Swal.fire({
          icon: "error",
          title: "Error",
          text: "Failed to delete user. " + res.message,
        });
      }
    },
  });
});
