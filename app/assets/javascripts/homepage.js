function G(id) {
    return document.getElementById(id);
}

var from_str;
var to_str;

var map = new BMap.Map("map_container");
map.enableContinuousZoom();
map.enableScrollWheelZoom();
var point = new BMap.Point(116.404, 39.915);
map.centerAndZoom(point, 15);

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
        from_str = G("from").value;
        to_str = G("to").value;
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
            // alert(addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
        });
    }
    else {
        alert('failed'+this.getStatus());
    }
});

// trigger the route finder when dest input
to.addEventListener("onconfirm", function(e) {
    var _value = e.item.value;
    // to_str = _value.province + _value.city + _value.district + _value.street + _value.business;
    from_str = G("from").value;
    to_str = G("to").value;
    driving.search( from_str, to_str );
    var data = "no value";
    myGeo.getPoint( from_str, function(p){
        if (p) {
            $("#route_record_lng_s").prop("value", p.lng);
            $("#route_record_lat_s").prop("value", p.lat);
            data = p.lng + ":" + p.lat;
        }
    }, "上海市");
    myGeo.getPoint( to_str, function(p){
        if (p) {
            data += ";" + p.lng + ":" + p.lat;
            $("#route_record_lng_d").prop("value", p.lng);
            $("#route_record_lat_d").prop("value", p.lat);
            $("#route_record_data").prop("value", data);
        }
    }, "上海市" );
    G("info").innerHTML = from_str + " 到 " + to_str;
});