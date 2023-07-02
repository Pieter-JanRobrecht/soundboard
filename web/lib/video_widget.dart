import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

final StreamController<String> streamController = StreamController();
const String wsUrl = 'ws://localhost:8080/gs-guide-websocket';
const String destination = '/topic/videos';

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
      streamController.sink.add(frame.body!);
    },
  );
}

class _VideoWidgetState extends State<VideoWidget> {
  final _controller = YoutubePlayerController(
    params: const YoutubePlayerParams(
      playsInline: true,
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
        return YoutubePlayer(
          controller: _controller..loadVideoById(videoId: '${snapshot.data}'),
        );
      },
    );
  }

  @override
  void dispose() {
    stompClient.deactivate();
    _controller.close();
    super.dispose();
  }
}
