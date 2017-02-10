$(document).ready(function () {

    window.setInterval(function () {
        console.debug('Checking health');

        $.get("test", function (healthChecks) {
            $(healthChecks).each(function (i, healthCheck) {
                console.log(healthCheck.url);

            });
        });
    }, 5000);
});