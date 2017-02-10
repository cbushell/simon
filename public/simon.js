$(document).ready(function () {

    window.setInterval(function () {
        console.debug('Checking health');

        $.get("test", function (data) {
            console.log(data);
        });
    }, 5000);
});