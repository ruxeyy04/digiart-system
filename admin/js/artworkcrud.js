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
                                    <a href="#!" class="btn btn-danger delete-artwork" data-artworkid="${
                                      artwork.Artwork_ID
                                    }">Delete</a>
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
displayartwork();
$(document).on("click", ".delete-artwork", function () {
  let id = $(this).data("artworkid");
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
          displayartwork();
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
