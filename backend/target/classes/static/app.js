var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

// 3. This function creates an <iframe> (and YouTube player)
//    after the API code downloads.
var player;

var stompClient = null;

function connect() {
    var socket = new SockJS('/gs-guide-websocket');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function (frame) {
        console.log('Connected: ' + frame);
        stompClient.subscribe('/topic/videos', function (greeting) {
            console.log(greeting.body.content);
            player.loadVideoById(greeting.body);
        });
    });
}

function createPlayer() {
    player = new YT.Player('player', {
        height: '390',
        width: '640',
        playerVars: {
            'playsinline': 1
        },
    });
}

$(function () {
    connect();
    createPlayer();
});
