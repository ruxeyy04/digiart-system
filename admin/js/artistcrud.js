$("#addArtistForm").on("submit", function (event) {
  event.preventDefault();
  var formData = new FormData(this);

  $.ajax({
    url: url + "api/artists/add",
    type: "POST",
    data: formData,
    processData: false,
    contentType: false,
    success: function (response) {

      if (response.success) {
        Swal.fire({
          icon: "success",
          title: "Success",
          text: "Artist added successfully!",
        }).then(function () {
          $("#addArtistModal").modal("hide");
          $("#addArtistForm")[0].reset();
          artistTable.ajax.reload();
        });
      } else {
        Swal.fire({
          icon: "error",
          title: "Error",
          text: "Failed to add artist. " + result.message,
        });
      }
    },
    error: function () {
      Swal.fire({
        icon: "error",
        title: "Error",
        text: "An error occurred while adding the artist.",
      });
    },
  });
});

var artistTable = $('#artist').DataTable({
    "ajax": {
      "url": url + "api/artists/get",
      "dataSrc": "data"
    },
    "columns": [
      {
        "data": "photo",
        "render": function(data, type, row) {
          return '<img src="' + data + '?_=' + new Date().getTime() +'" width="100px" height="100px">';
        }
      },
      { "data": "User_ID" },
      { "data": "Username" },
      { "data": "Firstname" },
      { "data": "Lastname" },
      { "data": "Contact_number" },
      { "data": "Gender" },
      { "data": "Email" },
      {
        "data": "User_ID",
        "render": function(data, type, row) {
          return `
            <div class="btn-group">
              <button class="btn btn-info view" data-artistid="${data}">View</button>
              <button class="btn btn-warning edit" data-artistid="${data}">Edit</button>
            </div>
          `;
        }
      }
    ]
  });

  $(document).on('click', '.view', function () {
    let userId = $(this).data('artistid');

    // Open the modal
    $('#viewArtistModal').modal('show');

    // Fetch artist information and artworks via AJAX
    $.ajax({
        url: url + 'api/artists/view?userid=' + userId,
        type: 'GET',
        dataType: 'json',
        success: function (response) {
            // Populate artist information
            $('#artistPhoto').attr('src', response.userinfo.photo);
            $('#artistName').text(response.userinfo.Username);
            $('#artistContact').text(response.userinfo.Contact_number);
            $('#artistCountry').text(response.userinfo.Country);
            $('#artistEmail').text(response.userinfo.Email);

            // Populate artworks
            var artworksHtml = '';
            $.each(response.artworks, function (index, artwork) {
                artworksHtml += `
                    <div class="col-md-3 mb-3">
                        <div class="card">
                            <img src="${artwork.photo}" class="card-img-top" alt="Artwork"  height="150">
                            <div class="card-body">
                                <p class="card-text"><strong>Artwork ID:</strong> ${artwork.Artwork_ID}</p>
                                <p class="card-text"><strong>Art Style:</strong> ${artwork.Artstyle}</p>
                                <p class="card-text"><strong>Date Posted:</strong> ${artwork.Date_posted}</p>
                                <p class="card-text"><strong>Price:</strong> ${artwork.Price}</p>
                            </div>
                        </div>
                    </div>`;
            });
            $('#artistArtworks').html(artworksHtml);
        },
        error: function () {
            // Handle error
            console.log('Error fetching artist information.');
        }
    });
});
$(document).on('click', '.edit', function () {
    let userId = $(this).data('artistid');
    $.ajax({
        type: "GET",
        url: url + "api/artists/getinfo",
        data: { userid: userId },
        dataType: "json",
        success: function (res) {
            // Populate the form fields with artist information
            $('#editArtistModal').modal('show');
            $('#editArtistForm input[name="User_ID"]').val(res.User_ID);
            $('#editArtistForm input[name="Username"]').val(res.Username);
            $('#editArtistForm input[name="Firstname"]').val(res.Firstname);
            $('#editArtistForm input[name="Lastname"]').val(res.Lastname);
            $('#editArtistForm input[name="Contact_number"]').val(res.Contact_number);
            $('#editArtistForm input[name="Country"]').val(res.Country);
            $('#editArtistForm select[name="Gender"]').val(res.Gender);
            $('#editArtistForm input[name="Email"]').val(res.Email);
        },
        error: function () {
            console.log('Error fetching artist information.');
        }
    });
});

$(document).on('submit', '#editArtistForm', function (event) {
  event.preventDefault();

  var formData = new FormData(this);

  $.ajax({
      url: url + 'api/artists/update',
      type: 'PUT',
      data: formData,
      contentType: false,
      processData: false,
      success: function (response) {
          if (response.success) {
              Swal.fire({
                  icon: 'success',
                  title: 'Success',
                  text: 'Artist updated successfully!'
              }).then(function () {
                  // Close the modal
                  $('#editArtistModal').modal('hide');
                  // Reset form
                  $("#editArtistForm")[0].reset();
                  // Reload DataTable
                  artistTable.ajax.reload();
              });
          } else {
              Swal.fire({
                  icon: 'error',
                  title: 'Error',
                  text: 'Failed to update artist. ' + response.message
              });
          }
      },
      error: function () {
          // Show error message with SweetAlert for AJAX errors
          Swal.fire({
              icon: 'error',
              title: 'Error',
              text: 'An error occurred while updating the artist. Please try again later.'
          });
      }
  });
});
