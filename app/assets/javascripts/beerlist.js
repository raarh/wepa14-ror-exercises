/**
 * Created by arto on 24.2.2014.
 */
$(document).ready(function () {
    $.getJSON('beers.json', function (beers) {
        oluet = beers
        $("#beers").html("oluita löytyi "+beers.length);
    });
});