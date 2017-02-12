$(document).ready(function () {

    window.setInterval(function () {
        console.debug('Checking health');

        $.get("test", function (healthChecks) {
            $(healthChecks).each(function (i, healthCheck) {
                console.log(healthCheck);

                if (healthCheck.responseCode != 200) {
                    $("div:contains(" + healthCheck.url + ")").toggleClass("healthy unhealthy");
                }

                $("div:contains(" + healthCheck.url + ") .stats").text(
                    "#tests: " + healthCheck.numberOfTestsPerformed +
                    " #failed:" + healthCheck.failCount +
                    " #succeeded: " + healthCheck.successCount
                )
                ;
            });
        });
    }, 5000);
});