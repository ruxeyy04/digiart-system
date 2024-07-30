function urlLink() {
  let urlLink = "https://digiarts.logiclynxz.com/";
  return urlLink;
}
let url = urlLink();
var userid = "";
if ($.cookie("user_id")) {
  userid = $.cookie("user_id");
}
var fullHeight = function () {
  $(".js-fullheight").css("height", $(window).height());
  $(window).resize(function () {
    $(".js-fullheight").css("height", $(window).height());
  });
};
fullHeight();

$("#sidebarCollapse").on("click", function () {
  $("#sidebar").toggleClass("active");
});

$(document).on("click", "#logout", function (event) {
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
      $.removeCookie("user_id", { path: "/" });
      $.removeCookie("usertype", { path: "/" });

      Swal.fire({
        title: "Logged out!",
        text: "You have been logged out successfully.",
        icon: "success",
      }).then(() => {
        window.location.href = "../login.html";
      });
    }
  });
});
$("#profileEdit").on("click", function () {
  $("#editProfile").modal("show");
});

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
        .attr("src", "../profile/" + userid + ".JPG?_=" + new Date().getTime())
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
            $("#editProfile").modal("hide");
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