$(document).ready(function () {

    window.setInterval(function () {
        console.debug('Checking health');

        $.get("test", function (healthChecks) {
            $(healthChecks).each(function (i, healthCheck) {
                console.log(healthCheck.url);

                if(healthCheck.responseCode != 200){
                    $("div:contains(" + healthCheck.url + ")").toggleClass("healthy unhealthy");
                }

            });
        });
    }, 5000);
});