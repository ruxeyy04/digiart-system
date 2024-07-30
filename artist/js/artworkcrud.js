function displayartwork() {
  $.ajax({
    type: "GET",
    url: url + "api/artwork/get",
    dataType: "json",
    success: function (res) {
      if (res && res.length > 0) {
        $("#artworks").empty();

        res.forEach(function (artwork) {
          var cardHtml = `
                        <div class="col-md-3 mb-3">
                            <div class="card">
                                <img class="card-img-top" src="/arts/${
                                  artwork.Artwork_ID
                                }.JPG?_=${new Date().getTime()}" alt="Card image cap" height="300">
                                <div class="card-body">
                                    <h5 class="card-title">Artist: ${
                                      artwork.Artist_Username
                                    }</h5>
                                    <p class="card-text"><strong>Artwork ID:</strong> ${
                                      artwork.Artwork_ID
                                    }</p>
                                    <p class="card-text"><strong>Art Style:</strong> ${
                                      artwork.Artstyle
                                    }</p>
                                    <p class="card-text"><strong>Date Posted:</strong> ${
                                      artwork.Date_posted
                                    }</p>
                                    <p class="card-text"><strong>Price:</strong> ${
                                      artwork.Price
                                    }</p>
                                </div>
                            </div>
                        </div>
                    `;
          $("#artworks").append(cardHtml);
        });
      }
    },
    error: function () {
      // Handle error
      console.log("Error fetching artworks.");
    },
  });
}

function displaymyartwork() {
  $("#myartworks").empty();
  $.ajax({
    type: "GET",
    url: url + "api/artwork/get?userid=" + userid,
    dataType: "json",
    success: function (res) {
      if (res && res.length > 0) {
        $("#artworks").empty();

        res.forEach(function (artwork) {
          var cardHtml = `
                        <div class="col-md-3 mb-3">
                            <div class="card">
                                <img class="card-img-top" src="/arts/${
                                  artwork.Artwork_ID
                                }.JPG?_=${new Date().getTime()}" alt="Card image cap" height="300">
                                <div class="card-body">
                                    <h5 class="card-title">Artist: ${
                                      artwork.Artist_Username
                                    }</h5>
                                    <p class="card-text"><strong>Artwork ID:</strong> ${
                                      artwork.Artwork_ID
                                    }</p>
                                    <p class="card-text"><strong>Art Style:</strong> ${
                                      artwork.Artstyle
                                    }</p>
                                    <p class="card-text"><strong>Date Posted:</strong> ${
                                      artwork.Date_posted
                                    }</p>
                                    <p class="card-text"><strong>Price:</strong> ${
                                      artwork.Price
                                    }</p>
                                    <a href="#!" class="btn btn-danger deleteArt" data-art_id="${
                                      artwork.Artwork_ID
                                    }">Delete</a>
                                  <a href="#!" class="btn btn-info editArt" data-art_id="${
                                    artwork.Artwork_ID
                                  }">Edit</a>
                                </div>
                            </div>
                        </div>
                    `;
          $("#myartworks").append(cardHtml);
        });
      }
    },
    error: function () {
      // Handle error
      console.log("Error fetching artworks.");
    },
  });
}
if (/\/[a]rtworks\.html$/.test(window.location.pathname)) {
  displayartwork();
}
if (/\/[m]yartwork\.html$/.test(window.location.pathname)) {
  displaymyartwork();
}

$(document).on("submit", "#addArtworkForm", function (event) {
  event.preventDefault();
  var formData = new FormData(this);
  formData.append("userid", userid);
  $.ajax({
    type: "POST",
    url: url + "api/artwork/add",
    data: formData,
    dataType: "json",
    processData: false,
    contentType: false,
    success: function (response) {
      if (response.success) {
        $("#addArtwork").modal("hide");
        displaymyartwork();
        Swal.fire({
          icon: "success",
          title: "Success",
          text: response.message || "Artwork added successfully!",
          timer: 2000,
          onClose: () => {},
        });
      } else {
        Swal.fire({
          icon: "error",
          title: "Error",
          text: response.message || "Failed to add artwork.",
          timer: 2000,
          onClose: () => {},
        });
      }
    },
    error: function (xhr, status, error) {
      Swal.fire({
        icon: "error",
        title: "Error",
        text: "Failed to add artwork. Please try again later.",
        timer: 2000,
        onClose: () => {},
      });
    },
  });
});

$(document).on("click", ".editArt", function () {
  let artid = $(this).data("art_id");
  $.ajax({
      type: "GET",
      url: url + "api/artwork/getinfo",
      data: { art_id: artid },
      dataType: "json",
      success: function (res) {
          if (res.success) {
              const artwork = res.data;
              // Populate the form with the retrieved data
              $("#editArtworkForm select[name='artstyle']").val(artwork.Artstyle);
              $("#editArtworkForm input[name='date_posted']").val(artwork.Date_posted);
              $("#editArtworkForm input[name='price']").val(artwork.Price);
              $("#editArtworkForm input[name='art_id']").val(artwork.Artwork_ID);
              // Show the modal
              $("#editArtwork").modal("show");
          } else {
              Swal.fire({
                  icon: 'error',
                  title: 'Error',
                  text: res.message || 'Failed to retrieve artwork details.',
                  timer: 2000
              });
          }
      },
      error: function (xhr, status, error) {
          Swal.fire({
              icon: 'error',
              title: 'Error',
              text: 'Failed to retrieve artwork details. Please try again later.',
              timer: 2000
          });
      }
  });
});

$(document).on("submit", "#editArtworkForm", function (event) {
  event.preventDefault();
  var formData = new FormData(this);
  $.ajax({
      type: "PUT",
      url: url + "api/artwork/update",
      data: formData,
      dataType: "json",
      processData: false,
      contentType: false, 
      success: function (res) {
          if (res.success) {
            displaymyartwork();
            $("#editArtworkForm")[0].reset();
            $('.custom-file-input').next('.custom-file-label').html('Choose Image');
            $("#editArtwork").modal("hide");
              Swal.fire({
                  icon: 'success',
                  title: 'Success',
                  text: 'Artwork updated successfully!',
                  timer: 2000,
              });
          } else {
              Swal.fire({
                  icon: 'error',
                  title: 'Error',
                  text: res.message || 'Failed to update artwork.',
                  timer: 2000
              });
          }
      },
      error: function (xhr, status, error) {
          Swal.fire({
              icon: 'error',
              title: 'Error',
              text: 'An error occurred while updating the artwork. Please try again later.',
              timer: 2000
          });
      }
  });
});

$(document).on("click", ".deleteArt", function () {
  let id = $(this).data("art_id");
  $('#deleteArtworkForm input[name="artworkid"]').val(id);
  $("#artworkID").html(id);
  $("#deleteArtwork").modal("show");
});

$(document).on("submit", "#deleteArtworkForm", function (event) {
  event.preventDefault();
  var formData = new FormData(this);

  $.ajax({
    type: "DELETE",
    url: url + "api/artwork/delete",
    data: formData,
    dataType: "json",
    contentType: false,
    processData: false,
    success: function (res) {
      if (res.success) {
        Swal.fire({
          icon: "success",
          title: "Success",
          text: "Artwork deleted successfully!",
        }).then(function () {
          displaymyartwork();
          $("#deleteArtwork").modal("hide");
        });
      } else {
        Swal.fire({
          icon: "error",
          title: "Error",
          text: "Failed to delete artwork. " + res.message,
        });
      }
    },
  });
});
