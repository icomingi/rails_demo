function G(id) {
    return document.getElementById(id);
}

function handleGPS( type, string ) {
    myGeo.getPoint(string, function(p){
        if (p) {
            setGPS( type, p );
        } else {
            alert("no GPS result for " + string);
        }
    }, "上海市");

    function setGPS( s, point ) {
        if ( s == "src" ) {
            $("#route_record_lng_s").prop("value", point.lng);
            $("#route_record_lat_s").prop("value", point.lat);
            data = point.lng + ":" + point.lat;
        }
        if ( s == "des") {
            $("#route_record_lng_d").prop("value", point.lng);
            $("#route_record_lat_d").prop("value", point.lat);
            data += ";" + point.lng + ":" + point.lat;
            $("#route_record_data").prop("value", data);
        } else {
            return;
        }
    }
}

function updateInput() {
    from_str = G("from").value;
    to_str = G("to").value;
}

var from_str;
var to_str;
var data;
var map = new BMap.Map("map_container");
var initPoint = new BMap.Point(121.404, 42.915);
map.enableContinuousZoom();
map.enableScrollWheelZoom();
map.centerAndZoom(initPoint, 15);

var driving = new BMap.DrivingRoute(map, {renderOptions:{map: map, autoViewport: true}});
var traffic = new BMap.TrafficLayer();
// map.addTileLayer(traffic);

var from = new BMap.Autocomplete( //建立一个自动完成的对象
{
    "input": "from",
    "location": "上海市"
});

var to = new BMap.Autocomplete({
    "input": "to",
    "location": "上海市"
});

var geolocation = new BMap.Geolocation();
var myGeo = new BMap.Geocoder();

// init
(function(){
    if ( document.title == "Dashboard") {
        var record = $("tbody tr:first");
        from_str = record.find(".from").text();
        to_str = record.find(".to").text();
        var table = $("table tr");
        table.click( function(){
            from_str = $(this).find(".from").text();
            to_str = $(this).find(".to").text();
            driving.search( from_str, to_str );
        });
    } else if ( document.title == "Home" ) {
        updateInput();
    }
})();

geolocation.getCurrentPosition(function(r){
    if(this.getStatus() == BMAP_STATUS_SUCCESS){
        var mk = new BMap.Marker(r.point);
        map.addOverlay(mk);
        map.panTo(r.point);
        var cor = r.point.lng + r.point.lat;
        // alert('您的位置：'+r.point.lng+','+r.point.lat);

        //parse coordinate
        var gc = new BMap.Geocoder();
        gc.getLocation(r.point, function(rs){
            var addComp = rs.addressComponents;
            from.setInputValue( addComp.city + addComp.district + addComp.street + addComp.streetNumber );
            updateInput();
            // alert(addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
        });
    }
    else {
        alert('failed'+this.getStatus());
    }
});

from.addEventListener("onconfirm", function(e) {
    handleGPS( "src", from_str );
});

// trigger the route finder when dest input
to.addEventListener("onconfirm", function(e) {
    var _value = e.item.value;
    // to_str = _value.province + _value.city + _value.district + _value.street + _value.business;
    updateInput();
    driving.search( from_str, to_str );

    handleGPS( "des", to_str );
    G("info").innerHTML = from_str + " 到 " + to_str;
});