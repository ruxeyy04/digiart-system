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
      var result = JSON.parse(response);
      if (result.success) {
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
              <button class="btn btn-info viewratings" data-artistid="${data}" data-toggle="modal" data-target="#ratingsModal">View</button>
            </div>
          `;
        }
      },      
      {
        "data": "User_ID",
        "render": function(data, type, row) {
          return `
            <div class="btn-group">
              <button class="btn btn-info view" data-artistid="${data}">View</button>
            </div>
          `;
        }
      }
    ]
  });

  $(document).on('click', '.viewratings', function () {
    let userId = $(this).data('artistid');
    $.ajax({
      type: "GET",
      url: url+"api/ratings/getartistratings",
      data: {artistid:userId},
      dataType: "json",
      success: function (response) {
        var html = ""
        if (response.data === 0) {
          $("#overallrating").html(0);  
          $("#ratingfield").hide();        
          html += `
          <div class="col-12 text-center">
            <h3>No ratings yet</h3>
          </div>
          `
        }else{
          $("#overallrating").html(response.totalrating);  
          $("#ratingfield").show();                
          $.map(response.data, function (element) {
            let starsHtml = '';
            for (let index = 0; index < element.rating; index++) {
                starsHtml += `<i class="fa fa-star"></i>`;
            }
        
            html += `
            <div class="col-md-6">
                <div class="card mb-3">
                    <div class="row g-0">
                        <div class="col-md-4">
                            <img
                                src="../profile/${element.User_ID}.JPG"
                                alt="Trendy Pants and Shoes"
                                class="img-fluid rounded-start"
                                style="height: 100%; width: 100%;"
                            />
                        </div>
                        <div class="col-md-8">
                            <div class="card-body">
                                <p class="card-title">${element.Artstyle} - ₱${element.commi_price}</p>
                                <small class="text-muted">Feedback from ${element.client}</small><br/>
                                <small class="text-muted"> 
                                    <div class="star-rating" style="color:#eac406;">
                                        ${starsHtml}
                                    </div>
                                </small>
                                <p class="card-text">
                                    ${element.comment}
                                </p>
                                <p class="card-text">
                                    <small class="text-muted">Date Commissioned ${element.date_commissioned}</small>
                                </p>
                            </div>
                        </div>
                    </div>
                </div> 
            </div>
            `;
        });
        
        }
        $("#artist-ratings").html(html);
      }
    });
  })

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
