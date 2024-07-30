$(document).on('submit', '#registerForm', function (event) {
    event.preventDefault();
    var formData = new FormData(this);

    $.ajax({
        type: "POST",
        url: url + "api/auth/register",
        data: formData,
        dataType: "json",
        contentType: false,
        processData: false,
        success: function (res) {
            if (res.success) {
                Swal.fire({
                    icon: 'success',
                    title: 'Success',
                    text: 'Registration successful!'
                }).then(function () {
                    $('#registerForm')[0].reset();
                    $('#registerModal').modal('hide');
                });
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Registration failed. ' + res.message
                });
            }
        },
        error: function () {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'An error occurred while registering. Please try again later.'
            });
        }
    });
});

$(document).on('submit', '#loginForm', function (event) {
    event.preventDefault();
    var formData = new FormData(this);

    $.ajax({
        type: "POST",
        url: url + "api/auth/login",
        data: formData,
        dataType: "json",
        contentType: false,
        processData: false,
        success: function (res) {
            if (res.success) {
                // Set cookies
                $.cookie('user_id', res.userid);
                $.cookie('usertype', res.usertype);

                // Show success message with SweetAlert
                Swal.fire({
                    icon: 'success',
                    title: 'Login Successful',
                    text: 'You have been successfully logged in!',
                    allowOutsideClick: false,
                    allowEscapeKey: false,
                    confirmButtonText: 'OK'
                }).then(function () {
                    // Redirect based on usertype
                    if (res.usertype === 'client') {
                        window.location.href = '/index.html';
                    } else if (res.usertype === 'artist') {
                        window.location.href = '/artist/';
                    } else if (res.usertype === 'admin') {
                        window.location.href = '/admin/';
                    }
                });
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Login failed. ' + res.message
                });
            }
        },
        error: function () {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'An error occurred while logging in. Please try again later.'
            });
        }
    });
});
