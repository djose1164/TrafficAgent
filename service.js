const BASE = "http://10.0.2.2:8080" //"http://127.0.0.1:8080";

function request(verb, endpoint, callback, obj) {
    const xhr = new XMLHttpRequest;
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status !== 200)
                root.state = "invalidCredentials"
            if (callback) {
                const res = JSON.parse(xhr.responseText.toString());
                callback(res);
            }
        }
    }
    xhr.open(verb, BASE + (endpoint ? endpoint : "/"));
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.setRequestHeader("Accept", "application/json");
    xhr.send(obj ? JSON.stringify(obj) : "");
}

function requestUrl(url, callback) {
    const xhr = new XMLHttpRequest;
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            const response = JSON.parse(xhr.responseText.toString());
            callback(response);
        }
    }
    xhr.open("GET", url);
    xhr.send();
}

function trafficTickets(callback) {
    request("GET", "/traffic_tickets/", callback);
}

function vehicleByLicensePlate(licensePlate, callback) {
    request("GET", "/vehicles/"+licensePlate, callback);
}

function driverById(driverId, callback) {
    request("GET", "/drivers/"+driverId, callback);
}

function motiveById(motiveId, callback) {
    request("GET", "/traffic_tickets/"+motiveId, callback);
}

function allMotives(callback) {
    request("GET", "/traffic_tickets/", callback);
}

function weatherIn(name, callback) {
    request("GET", "/traffic_tickets/", callback);
}

function weatherIn(city, callbacak) {
    const cityUri = encodeURIComponent(city);
    const url = `http://api.openweathermap.org/data/2.5/weather?q=${cityUri}&type=like&APPID=7b6e61038914b2c13915adcb9087ce7d&lang=es&units=metric`
    requestUrl(url, callbacak)
}

function news(callback) {
    requestUrl("https://remolacha.net/wp-json/wp/v2/posts?search=digeset", callback);
}
