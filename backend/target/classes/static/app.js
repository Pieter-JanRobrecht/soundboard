const tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
const firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

let player;
let stompClient = null;

function connect() {
    const socket = new SockJS('/gs-guide-websocket');
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function (frame) {
        console.log('Connected: ' + frame);
        stompClient.subscribe('/topic/videos', function (greeting) {
            player.loadVideoById(greeting.body);
        });
    });
}

function createPlayer() {
    player = new YT.Player('player', {
        height: '390',
        width: '640',
        loop: 1,
        playerVars: {
            'playsinline': 1
        },
    });
}

$(function () {
    connect();
    createPlayer();
});
