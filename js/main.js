AOS.init();

function urlLink() {
   let urlLink = "https://digiarts.logiclynxz.com/";
//   let urlLink = "http://localhost/";
  return urlLink;
}
let url = urlLink();

var userid = "";
if ($.cookie("user_id")) {
  userid = $.cookie("user_id");
}

var today = new Date().toISOString().split("T")[0];

$("#deadline").prop("min", today);
if ($.cookie("user_id")) {
  $("#navbar").append(`
      <div class="cn">
          <a class="btn text-light" href="profile.html">
              <img src="/img/profile.png" alt="" /> Profile
          </a>
      </div>
      <div class="cn">
          <button class="btn text-light logout">
              Logout
          </button>
      </div>
  `);
} else {
  $("#navbar").append(`
      <div class="cn">
          <a class="btn text-light" href="login.html"> Login </a>
      </div>
  `);
}
$(document).on("click", ".logout", function (event) {
  Swal.fire({
    title: "Are you sure?",
    text: "You will be logged out.",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Yes, logout!",
  }).then((result) => {
    if (result.isConfirmed) {
      $.removeCookie("user_id");
      $.removeCookie("usertype");

      Swal.fire({
        title: "Logged out!",
        text: "You have been logged out successfully.",
        icon: "success",
      }).then(() => {
        window.location.href = "login.html";
      });
    }
  });
});

$.ajax({
  type: "GET",
  url: url + "api/artists/get",
  dataType: "json",
  success: function (response) {
    if (response.data) {
      response.data.forEach(function (artist) {
        let artistCard = `
                  <div class="artist-card col-md-3 col-sm-6" data-aos="fade-up" data-aos-duration="1000">
                      <div class="card">
                          <img src="${
                            artist.photo
                          }?_= ${new Date().getTime()}" class="card-img-top" alt="..." />
                          <div class="card-body">
                              <h5 class="card-title text-center text-white">
                                  ${artist.Firstname} ${artist.Lastname}
                              </h5>
                              <div class="row">
                                  <div class="cn col-sm-12 text-center">
                                      <a href="aprofile.html?userid=${
                                        artist.User_ID
                                      }" class="btn btn-dark mt-2">
                                          <img src="/img/profile.png" alt="" /> Artist Profile
                                      </a>
                                      <a href="#" class="btn btn-dark mt-2 commission-link" data-artistid="${
                                        artist.User_ID
                                      }">
                                          <img src="/img/commission.png" alt="" /> Commssion Now
                                      </a>

                                      <a href="#" class="btn btn-dark mt-2 rate-artist" data-artistid="${
                                        artist.User_ID
                                      }">
                                        Rate
                                      </a>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>
              `;
        $("#homeShowArtist").append(artistCard);
      });
    }
  },
  error: function () {
    console.error("An error occurred while fetching the artist data.");
  },
});

$.ajax({
  type: "GET",
  url: url + "api/artwork/get",
  dataType: "json",
  success: function (response) {
    if (response) {
      response.forEach(function (art) {
        let artCard = `
        <div class="artist-card col-md-3 col-sm-6" data-aos="fade-up" data-aos-duration="1000">
        <div class="cards">
          <div class="row">
            <div class="col-md-7">
              <label for="" class="aid text-white">ID: #${
                art.Artwork_ID
              }</label>
            </div>
            <div class="col-md-5">
              <label for="" class="aid text-white">₱ ${art.Price} </label>
            </div>
          </div>

          <img src="/arts/${
            art.Artwork_ID
          }.JPG?_=${new Date().getTime()}" class="card-img-top" alt="..." />
          <div class="card-body text-center">
            <div class="row text-white">
              <div class="col">${art.Artstyle}</div>
              <div class="col">01-02-03</div>
            </div>
            <h5 class="card-title text-center text-white">
              ${art.Artist_Firstname} ${art.Artist_Lastname}
            </h5>
          </div>
        </div>
      </div>
              `;
        $("#artworks").append(artCard);
      });
    }
  },
  error: function () {
    console.error("An error occurred while fetching the artist data.");
  },
});

$(document).on("click", ".commission-link", function (e) {
  var artistid = $(this).data("artistid");
  e.preventDefault();
  if ($.cookie("user_id")) {
    $("#artistcommi_id").val(artistid);
    $("#commisionForm").modal("show");
  } else {
    // Redirect to login page
    window.location.href = "login.html";
  }
});


var ratingID = ""
$(document).on("click", ".rate-artist", function () {
    if($.cookie("user_id") === undefined){
        Swal.fire(
          "Login required",
          "",
          "warning"
        ); 
    }else{
  var artistid = $(this).data("artistid");
  $.ajax({
    type: "GET",
    url: url+"api/ratings/getcommisionrating",
    data: {artistid:artistid, userid:$.cookie("user_id")},
    dataType: "json",
    success: function (response) {
      if (response.data === 0) {
        Swal.fire(
          "Nothing to rate",
          "You need to have completed commissions from the artist to rate the artist",
          "warning"
        );      
      } else {
        var html = ""
        $.map(response.data, function (element) {
          html += `<option value="${element.commID}">${element.Artstyle}</option>`
        });
        $("#Commission_ID").html(html);

        // Rate
        $.ajax({
          type: "GET",
          url: url+"api/ratings/checkhistory",
          data: {artistid:artistid, userid:$.cookie("user_id")},
          dataType: "json",
          success: function (response) {
            // console.log(response.data)
            if (response.data.number === 0) {
              Swal.fire(
                "Warning!",
                "No commision/s in this artist yet",
                "warning"
              );
            } else {
              $("#ratingForm").modal("show");
              $("#rating_artist_id").val(artistid);
            }
          }
        });
      }
    }
  });
    }

});

$(document).on("submit", "#submitUpdatedRating", function (event) {
  event.preventDefault();
  var formData = new FormData(this);
  formData.append("userid", userid);
  formData.append("ratingid", ratingID);
  
  // formData.forEach((value, key) => {
  //   console.log(key + ', ' + value);
  // });

  Swal.fire({
    title: "Are you sure?",
    text: "Please confirm that all details are correct before submitting.",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Yes, submit it!",
  }).then((result) => {
    if (result.isConfirmed) {
      $.ajax({
        type: "PUT",
        url: "api/ratings/update",
        data: formData,
        dataType: "json",
        processData: false,
        contentType: false,
        success: function (response) {
          $("#commisionForm").modal("hide");
          if (response.success) {
            Swal.fire(
              "Submitted!",
              `${response.message}`,
              "success"
            );   
            setTimeout(() => {
              window.location.reload()
            }, 2000);         
          } else {
            Swal.fire(
              "Error!",
              "There was an error submitting your rating.",
              "error"
            );
          }
        },
      });
    }
  });
});


$(document).on("submit", "#submitRating", function (event) {
  event.preventDefault();
  var formData = new FormData(this);
  formData.append("userid", userid);

  formData.forEach((value, key) => {
    console.log(key + ', ' + value);
  });

  Swal.fire({
    title: "Are you sure?",
    text: "Please confirm that all details are correct before submitting.",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Yes, submit it!",
  }).then((result) => {
    if (result.isConfirmed) {
      $.ajax({
        type: "POST",
        url: "api/ratings/add",
        data: formData,
        dataType: "json",
        processData: false,
        contentType: false,
        success: function (response) {
          $("#commisionForm").modal("hide");
          if (response.success) {
            Swal.fire(
              "Submitted!",
              "Your rating has been submitted.",
              "success"
            );
            setTimeout(() => {
              window.location.reload()
            }, 2000);   
          } else {
            Swal.fire(
              "Error!",
              "There was an error submitting your rating.",
              "error"
            );
          }
        },
      });
    }
  });
});

$(document).on("submit", "#commiForm", function (event) {
  event.preventDefault();
  var formData = new FormData(this);
  formData.append("userid", userid);

  Swal.fire({
    title: "Are you sure?",
    text: "Please confirm that all details are correct before submitting.",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Yes, submit it!",
  }).then((result) => {
    if (result.isConfirmed) {
      $.ajax({
        type: "POST",
        url: "api/commision/add",
        data: formData,
        dataType: "json",
        processData: false,
        contentType: false,
        success: function (response) {
          $("#commisionForm").modal("hide");
          if (response.success) {
            Swal.fire(
              "Submitted!",
              "Your commission has been submitted.",
              "success"
            );
          } else {
            Swal.fire(
              "Error!",
              "There was an error submitting your commission.",
              "error"
            );
          }
        },
      });
    }
  });
});

if (/\/[a]profile\.html$/.test(window.location.pathname)) {
  var urlParams = new URLSearchParams(window.location.search);
  var userId = urlParams.get("userid");

  if (!userId) {
    window.location.href = "index.html";
  } else {
    $.ajax({
      url: "api/artists/view?userid=" + userId,
      type: "GET",
      dataType: "json",
      success: function (response) {
        if (response.error) {
          window.location.href = "index.html";
        }
        
        $("#ArtisitProfilePhoto").attr("src", response.userinfo.photo);
        $("#ArtisitProfileUsername").text(response.userinfo.Username);
        $("#ArtisitProfileGender").text(response.userinfo.Gender);
        $("#ArtisitProfileCounty").text(response.userinfo.Country);
        $("#ArtisitProfileEmail").text(response.userinfo.Email);
        
        console.log(response.userinfo.averagerating)
        $("#OverAllRating").text("Overall Rating: "+response.userinfo.averagerating+" / 5");

        // Populate artworks
        var artworksHtml = "";

        $.each(response.artworks, function (index, artwork) {
          artworksHtml += `
                  <div class="artist-card col-md-3 col-sm-6" data-aos="fade-up" data-aos-duration="1000">
                  <div class="cards">
                    <div class="row">
                      <div class="col-md-7">
                        <label for="" class="aid text-white">ID: #${
                          artwork.Artwork_ID
                        }</label>
                      </div>
                      <div class="col-md-5">
                        <label for="" class="aid text-white">₱ ${
                          artwork.Price
                        } </label>
                      </div>
                    </div>
          
                    <img src="/arts/${
                      artwork.Artwork_ID
                    }.JPG?_=${new Date().getTime()}" class="card-img-top" alt="..." />
                    <div class="card-body text-center">
                      <div class="row text-white">
                        <div class="col">${artwork.Artstyle}</div>
                        <div class="col">01-02-03</div>
                      </div>
                    </div>
                  </div>
                </div>
                        `;
        });
        $("#artworksProfile").html(artworksHtml);
      },
      error: function () {
        console.log("Error fetching artist information.");
      },
    });
  }
}

if (/\/[p]rofile\.html$/.test(window.location.pathname)) {
  function profileInfo() {
    $.ajax({
      type: "GET",
      url: url + "api/auth/getprofile",
      data: { userid: userid },
      dataType: "json",
      success: function (response) {
        if (response.error) {
          Swal.fire({
            icon: "error",
            title: "Error",
            text: response.error,
          }).then(() => {
            window.location.href = "index.html";
          });
          return;
        }

        $("#fullname").text(
          response.userinfo.Firstname + " " + response.userinfo.Lastname
        );
        $("#profileimg")
          .attr(
            "src",
            "../profile/" + userid + ".JPG?_=" + new Date().getTime()
          )
          .on("error", function () {
            $(this).attr("src", "../profile/default.jpg");
          });
        $("#gender").text(response.userinfo.Gender);
        $("#country").text(response.userinfo.Country);
        $("#email").text(response.userinfo.Email);
        $("#username").text(response.userinfo.Username);

        $('input[name="username"]').val(response.userinfo.Username);
        $('input[name="fname"]').val(response.userinfo.Firstname);
        $('input[name="lname"]').val(response.userinfo.Lastname);
        $('input[name="contact"]').val(response.userinfo.Contact_number);
        $('input[name="country"]').val(response.userinfo.Country);
        $('select[name="gender"]').val(response.userinfo.Gender);
        $('input[name="email"]').val(response.userinfo.Email);
      },
      error: function () {
        Swal.fire({
          icon: "error",
          title: "Error",
          text: "Error fetching profile information.",
        });
      },
    });
  }

  profileInfo();
  $(document).on("submit", "#updateProfileForm", function (event) {
    event.preventDefault();
    var formData = new FormData(this);
    formData.append("userid", userid);

    $.ajax({
      type: "PUT",
      url: url + "api/auth/updateprofile",
      data: formData,
      dataType: "json",
      processData: false,
      contentType: false,
      success: function (res) {
        if (res.success) {
          Swal.fire({
            icon: "success",
            title: "Success",
            text: "Profile updated successfully!",
          }).then(function () {
            $("#edit").modal("hide");
            profileInfo();
          });
        } else {
          Swal.fire({
            icon: "error",
            title: "Error",
            text: "Failed to update Profile. " + res.message,
          });
        }
      },
      error: function () {
        Swal.fire({
          icon: "error",
          title: "Error",
          text: "An error occurred while updating the Profile. Please try again later.",
        });
      },
    });
  });

// Check if DataTables library is loaded
if (typeof $.fn.DataTable === 'function') {
  var commisionTable = $("#commisionList").DataTable({
      ajax: {
          url: url + "api/commision/getclientcommi?userid=" + userid,
              data: function(d) {

                d.status = $('#statusFilter').val();
              },
          dataSrc: "data",
      },
      columns: [
          { data: "Commission_ID" },
          {
              data: null,
              render: function (data, type, row) {
                  return data.Firstname + " " + data.Lastname;
              },
          },
          { data: "Artstyle" },
          {
              data: "deadline",
              render: function (data, type, row) {
                  var date = new Date(data);
                  var monthNames = [
                      "January", "February", "March", "April", "May", "June",
                      "July", "August", "September", "October", "November", "December"
                  ];
                  var formattedDate =
                      monthNames[date.getMonth()] + " " +
                      date.getDate() + ", " +
                      date.getFullYear();
                  return formattedDate;
              },
          },
          { data: "message" },
          {
              data: null,
              render: function (data, type, row) {
                  var statusBadge = "";
                  if (data.status === "Accepted" || data.status === "Completed") {
                      statusBadge = '<span class="badge badge-success">' + data.status + "</span>";
                  } else if (data.status === "Pending") {
                      statusBadge = '<span class="badge badge-warning">' + data.status + "</span>";
                  } else if (data.status === "In Progress" && data.paid !== null) {
                      statusBadge = '<span class="badge badge-primary">' + data.status + "</span>";
                      paidBadge = '<span class="badge badge-info">Paid</span>';
                  }  else {
                      statusBadge = '<span class="badge badge-danger">' + data.status + "</span>";
                  }
                  var paidBadge = "";
                  if (data.paid !== null && (data.status === "Accepted" || data.status === "Completed" || data.status === "In Progress")) {
                      paidBadge = '<span class="badge badge-info">Paid</span>';
                  }
                  return statusBadge + " " + paidBadge;
              },
          },
          {
              data: "commi_price",
              render: function (data, type, row) {
                  return data ? "₱ " + data : "Not Yet Issued";
              },
          },
          {
              data: null,
              render: function (data, type, row) {
                  if (data.status === "Pending") {
                      return `
                          <div class="btn-group">
                              <button class="btn btn-danger cancel" data-commi_id="${data.Commission_ID}">Cancel</button>
                              <button class="btn btn-warning edit" data-commi_id="${data.Commission_ID}">Edit</button>
                          </div>
                      `;
                  } else if (data.status === "Accepted" && data.paid === null) {
                      return `
                          <div class="btn-group">
                              <button class="btn btn-success pay" data-commi_id="${data.Commission_ID}">Pay</button>
                          </div>
                      `;
                  } else {
                      return "";
                  }
              },
          },
      ],
      order: []
  });
} else {
  console.error("DataTables library is not loaded.");
}
  $('#statusFilter').change(function() {
    commisionTable.ajax.reload();
  });
  $(document).on("click", ".edit", function () {
    let commid = $(this).data("commi_id");
    $.ajax({
      type: "GET",
      url: url + "api/commision/getinfo",
      data: { commid: commid },
      dataType: "json",
      success: function (res) {
        // Populate the edit commission form with retrieved data
        $("#editCommisionForm").find("[name='artstyle']").val(res.artstyle);
        $("#editCommisionForm").find("[name='deadline']").val(res.deadline);
        $("#editCommisionForm").find("[name='message']").val(res.message);
        $("#editCommisionForm").find("[name='commi_id']").val(res.commi_id);

        // Show the edit commission modal
        $("#editCommisionForm").modal("show");
      },
    });
  });

  $(document).on("click", ".cancel", function () {
    let commid = $(this).data("commi_id");

    Swal.fire({
      title: "Cancel Commission",
      text: "Are you sure you want to cancel this commission?",
      icon: "warning",
      showCancelButton: true,
      confirmButtonText: "Yes, cancel it",
      cancelButtonText: "No, keep it",
    }).then((result) => {
      if (result.isConfirmed) {
        $.ajax({
          type: "POST",
          url: url + "api/commision/cancel",
          data: { commid: commid },
          dataType: "json",
          success: function (res) {
            // Handle success
            Swal.fire({
              icon: "success",
              title: "Commission Canceled",
              text: "The commission has been canceled successfully.",
            });
            commisionTable.ajax.reload();
          },
          error: function () {
            Swal.fire({
              icon: "error",
              title: "Error",
              text: "An error occurred while canceling the commission. Please try again later.",
            });
          },
        });
      }
    });
  });

  $(document).on("submit", "#editCommiForm", function (event) {
    event.preventDefault();
    var formData = new FormData(this);

    $.ajax({
      type: "PUT",
      url: url + "api/commision/update",
      data: formData,
      contentType: false,
      processData: false,
      dataType: "json",
      success: function (res) {
        if (res.success) {
          $("#editCommisionForm").modal("hide");
          Swal.fire({
            icon: "success",
            title: "Success",
            text: res.message,
          }).then((result) => {
            if (result.isConfirmed) {
              commisionTable.ajax.reload();
            }
          });
        } else {
          Swal.fire({
            icon: "error",
            title: "Error",
            text: res.message,
          });
        }
      },
      error: function () {
        Swal.fire({
          icon: "error",
          title: "Error",
          text: "An error occurred while updating the commission. Please try again later.",
        });
      },
    });
  });

  $(document).on("click", ".pay", function () {
    let commi_id = $(this).data("commi_id");

    // Create FormData object and append commission ID
    var formData = new FormData();
    formData.append("commi_id", commi_id);

    // Display confirmation dialog
    Swal.fire({
      icon: "warning",
      title: "Confirmation",
      text: "Are you sure you want to mark this commission as paid?",
      showCancelButton: true,
      confirmButtonText: "Yes",
      cancelButtonText: "Cancel",
    }).then((result) => {
      if (result.isConfirmed) {
        // If user confirms, proceed with payment
        $.ajax({
          type: "PUT",
          url: url + "api/commision/pay",
          data: formData, // Send FormData object
          contentType: false, // Ensure jQuery does not set the content type
          processData: false, // Prevent jQuery from processing FormData
          dataType: "json",
          success: function (res) {
            if (res.success) {
              Swal.fire({
                icon: "success",
                title: "Success",
                text: res.message,
              }).then((result) => {
                if (result.isConfirmed) {
                  commisionTable.ajax.reload();
                }
              });
            } else {
              Swal.fire({
                icon: "error",
                title: "Error",
                text: res.message,
              });
            }
          },
          error: function () {
            Swal.fire({
              icon: "error",
              title: "Error",
              text: "An error occurred while marking the commission as paid. Please try again later.",
            });
          },
        });
      }
    });
  });
}
