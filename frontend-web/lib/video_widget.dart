import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

final StreamController<String> streamController = StreamController();
const String wsUrl = 'http://localhost:8080/soundboard-ws';
const String destination = '/topic/videos';

final stompClient = StompClient(
  config: StompConfig.SockJS(
    url: wsUrl,
    onConnect: onConnect,
  ),
);

void onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: destination,
    callback: (frame) => streamController.sink.add(frame.body!),
  );
}

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  final YoutubePlayerController _controller = YoutubePlayerController(
    params: const YoutubePlayerParams(
      loop: true,
    ),
  );

  @override
  void initState() {
    super.initState();
    stompClient.activate();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamController.stream,
      builder: (context, snapshot) {
        print('building');
        print('data [${snapshot.data}]');
        return YoutubePlayer(
            controller: _controller
              ..loadVideoById(videoId: '${snapshot.data}'));
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
