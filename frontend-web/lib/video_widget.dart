import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

final StreamController<List<String>> streamController = StreamController();
const String wsUrl = 'ws://localhost:8080/gs-guide-websocket';
const String destination = '/topic/videos';
var _listMessage = <String>[];

final stompClient = StompClient(
  config: StompConfig(
    url: wsUrl,
    onConnect: onConnect,
    onWebSocketError: (dynamic error) => print(error.toString()),
  ),
);

void onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: destination,
    callback: (frame) {
      print('onConnect');
      Map<String, dynamic> result = json.decode(frame.body!);
      //receive Message from topic
      _listMessage.add(result['content']);

      //Observe list message
      streamController.sink.add(_listMessage);
    },
  );
}

class _VideoWidgetState extends State<VideoWidget> {
  final _controller = YoutubePlayerController(
    params: const YoutubePlayerParams(
      loop: true,
    ),
  );
  final _channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:8080/gs-guide-websocket/topic/videos')
  );

  @override
  void initState() {
    super.initState();
    stompClient.activate();
    streamController.add(_listMessage);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamController.stream,
      builder: (context, snapshot) {
        print('building');
        print('data [${snapshot.data}]');
        return YoutubePlayer(controller: _controller..loadVideoById(videoId: '${snapshot.data}'));
        // return Text(snapshot.hasData ? '${snapshot.data}' : '');
      },
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.close();
    super.dispose();
  }
}