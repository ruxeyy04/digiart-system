var commiTable = $('#commisionlist').DataTable({

          ajax: {
          url: url + "api/commision/get?userid=" + userid,
              data: function(d) {

                d.status = $('#statusFilter').val();
              },
          dataSrc: "data",
      },
    "columns": [
      { "data": "Commission_ID" },
      { "data": null, render: function (data, type, row) {
        return data.cFname + ' ' + data.cLname
      } },
      { "data": "Artstyle" },
      { "data": "message" },
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
    {
        data: null,
        render: function (data, type, row) {
            var statusBadge = "";
            if (data.status === "Completed") {
                statusBadge = '<span class="badge badge-success">' + data.status + "</span>";
            }else if (data.status === "Accepted") {
                statusBadge = '<span class="badge badge-success">' + data.status + "</span>";
            }   else if (data.status === "Pending") {
                statusBadge = '<span class="badge badge-warning">' + data.status + "</span>";
            }  else if (data.status === "In Progress") {
                statusBadge = '<span class="badge badge-primary">' + data.status + "</span>";
            } else {
                statusBadge = '<span class="badge badge-danger">' + data.status + "</span>";
            }
            var paidBadge = "";
            if (data.paid !== null && (data.status === "In Progress" || data.status === "Completed"|| data.status === "Accepted")) {
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
                        <button class="btn btn-success accept" data-commi_id="${data.Commission_ID}">Accept</button>
                        <button class="btn btn-danger reject" data-commi_id="${data.Commission_ID}">Reject</button>
                    </div>
                `;
            } 
            if (data.status === "Accepted" && data.paid === 'Paid') {
                return `
                    <div class="btn-group">
                        <button class="btn btn-success inprogress" data-commi_id="${data.Commission_ID}">In Progress</button>
                    </div>
                `;
            } 
            if (data.status === "In Progress" && data.paid === 'Paid') {
                return `
                    <div class="btn-group">
                        <button class="btn btn-success complete" data-commi_id="${data.Commission_ID}">Complete</button>
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

  $('#statusFilter').change(function() {
    commiTable.ajax.reload();
  });
  $(document).on('click', '.accept', function () {
    let commi_id = $(this).data('commi_id');
    Swal.fire({
        title: 'Accept Commission',
        input: 'number',
        inputLabel: 'Enter the price for this commission',
        inputValidator: (value) => {
            if (!value) {
                return 'You need to enter a price!';
            }
        },
        showCancelButton: true,
        confirmButtonText: 'Accept',
        cancelButtonText: 'Cancel',
    }).then((result) => {
        if (result.isConfirmed) {
            let price = result.value;
            $.ajax({
                type: "POST",
                url: url + "api/commision/update_status",
                data: { commi_id: commi_id, status: 'Accepted', price: price },
                dataType: "json",
                success: function (res) {
                    if (res.success) {
                        commiTable.ajax.reload();
                        Swal.fire({
                            icon: 'success',
                            title: 'Accepted',
                            text: 'Commission has been accepted!',
                            timer: 2000,
                            onClose: () => {
                            }
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: res.message,
                            timer: 2000
                        });
                    }
                }
            });
        }
    });
});
$(document).on('click', '.inprogress', function () {
    let commi_id = $(this).data('commi_id');
    Swal.fire({
        title: 'In Progress Commission',
        text: "Are you sure you want to mark this commission as in progress?",
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Yes, i\'m doing it!',
        cancelButtonText: 'No, cancel!',
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                type: "POST",
                url: url + "api/commision/update_status",
                data: { commi_id: commi_id, status: 'In Progress' },
                dataType: "json",
                success: function (res) {
                    if (res.success) {
                        commiTable.ajax.reload();
                        Swal.fire({
                            icon: 'success',
                            title: 'Completed',
                            text: 'Commission has been marked as completed!',
                            timer: 2000,
                            onClose: () => {
                            }
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: res.message,
                            timer: 2000
                        });
                    }
                }
            });
        }
    });
});
$(document).on('click', '.reject', function () {
    let commi_id = $(this).data('commi_id');
    Swal.fire({
        title: 'Reject Commission',
        text: "Are you sure you want to reject this commission?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Yes, reject it!',
        cancelButtonText: 'No, cancel!',
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                type: "POST",
                url: url + "api/commision/update_status",
                data: { commi_id: commi_id, status: 'Rejected' },
                dataType: "json",
                success: function (res) {
                    if (res.success) {
                        commiTable.ajax.reload();
                        Swal.fire({
                            icon: 'success',
                            title: 'Rejected',
                            text: 'Commission has been rejected!',
                            timer: 2000,
                            onClose: () => {
                            }
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: res.message,
                            timer: 2000
                        });
                    }
                }
            });
        }
    });
});

$(document).on('click', '.complete', function () {
    let commi_id = $(this).data('commi_id');
    Swal.fire({
        title: 'Complete Commission',
        text: "Are you sure you want to mark this commission as completed?",
        icon: 'question',
        showCancelButton: true,
        confirmButtonText: 'Yes, complete it!',
        cancelButtonText: 'No, cancel!',
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                type: "POST",
                url: url + "api/commision/update_status",
                data: { commi_id: commi_id, status: 'Completed' },
                dataType: "json",
                success: function (res) {
                    if (res.success) {
                        commiTable.ajax.reload();
                        Swal.fire({
                            icon: 'success',
                            title: 'Completed',
                            text: 'Commission has been marked as completed!',
                            timer: 2000,
                            onClose: () => {
                            }
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: res.message,
                            timer: 2000
                        });
                    }
                }
            });
        }
    });
});
