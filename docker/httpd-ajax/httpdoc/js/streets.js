/**
 * Authors: Christopher Meier & Daniel Palumbo
 * Date: 31 may 2017
 */

$(function () {
    function loadStreets() {
        $.getJSON("api/streets/", function(data) {
            var content = $("#streets_content");
            var row;

            console.log(data);

            $("#streets_content > .row").remove();

            for(var i = 0; i < data.length; i++) {
                if(i % 4 == 0) {
                    content.append('<div class="row"></div>');
                    row = content.children().last();
                }
                row.append(
                    '<div class="col-md-3 col-sm-6">'+
                    '<div class="service-item">'+
                    '<span class="fa-stack fa-4x">'+
                    '<i class="fa fa-circle fa-stack-2x"></i>'+
                    '<i class="fa fa-compass fa-stack-1x text-primary"></i>'+
                    '</span>'+
                    '<h4>'+
                    '<strong>' + data[i].streetname +'</strong>'+
                    '</h4>'+
                    '<p>' + data[i].city + '</p>'+
                    '<a href="#" class="btn btn-light">Learn More</a>'+
                    '</div>'+
                    '</div>');
            }
        });
    }

    loadStreets();
    setInterval(loadStreets, 2000);

});