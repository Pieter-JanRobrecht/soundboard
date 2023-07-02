var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

// 3. This function creates an <iframe> (and YouTube player)
//    after the API code downloads.
var player;

var stompClient = null;

function setConnected(connected) {
    $("#connect").prop("disabled", connected);
    $("#disconnect").prop("disabled", !connected);
    if (connected) {
        $("#conversation").show();
    }
    else {
        $("#conversation").hide();
    }
    $("#greetings").html("");
}

function connect() {
    var socket = new SockJS('/gs-guide-websocket');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function (frame) {
        setConnected(true);
        console.log('Connected: ' + frame);
        stompClient.subscribe('/topic/greetings', function (greeting) {
            console.log(greeting.body.content);
            player.loadVideoById(greeting.body);
            // showGreeting(JSON.parse(greeting.body).content);
        });
    });
}

function disconnect() {
    if (stompClient !== null) {
        stompClient.disconnect();
    }
    setConnected(false);
    console.log("Disconnected");
}

function sendName() {
    stompClient.send("/app/hello", {}, JSON.stringify({'name': $("#name").val()}));
}

function showGreeting(message) {
    $("#greetings").append("<tr><td>" + message + "</td></tr>");
}

$(function () {
    connect();
});

function onYouTubeIframeAPIReady() {
    player = createPlayer('M7lc1UVf-VE');
}

// 4. The API will call this function when the video player is ready.
function onPlayerReady(event) {
    player.playVideo();
}

// 5. The API calls this function when the player's state changes.
//    The function indicates that when playing a video (state=1),
//    the player should play for six seconds and then stop.
var done = false;

function onPlayerStateChange(event) {
    if (event.data == YT.PlayerState.PLAYING && !done) {
        // setTimeout(stopVideo, 6000);
        setTimeout(function () {
            player.loadVideoById('K69tbUo3vGs')
        }, 6000);
        done = true;
    }
}

function stopVideo() {
    player.stopVideo();
}

function createPlayer() {
    return new YT.Player('player', {
        height: '390',
        width: '640',
        // videoId: videoId,
        playerVars: {
            'playsinline': 1
        },
        // events: {
        //     'onReady': onPlayerReady,
        //     'onStateChange': onPlayerStateChange
        // }
    });
}