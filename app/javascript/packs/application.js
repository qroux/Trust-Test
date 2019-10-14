import "bootstrap";

$(".alert" ).fadeOut(5000);
$(".alert-success" ).fadeOut(5000);
$(".alert-danger" ).fadeOut(5000);

document.getElementById("csv-uploader").onchange = function() {
    document.getElementById("csv-uploader").submit();
};
