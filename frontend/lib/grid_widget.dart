import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _getVideos(),
      builder: (context, snapshot) {
        return GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: _createButtons(videos: snapshot.data),
        );
      },
    );
  }

  Future<List<String>> _getVideos() async {
    final response = await get(Uri.parse("http://192.168.0.234:8080/videos"));
    return List<String>.from(jsonDecode(response.body));
  }

  List<Widget> _createButtons({required List<String>? videos}) {
    if (videos == null) {
      return List.empty();
    }

    return videos
        .map((video) => _buildButton(
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
            video: video))
        .toList();
  }

  ElevatedButton _buildButton({required Color? color, required String video}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: () => _requestSong(video),
      child: Text(video),
    );
  }

  _requestSong(String video) {
    get(Uri.parse("http://192.168.0.234:8080/play-video?video=$video"));
  }
}
