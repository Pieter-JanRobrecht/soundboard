import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  List<String> videos = [];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder(
        future: _getVideos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(
                child: Text('No connection'),
              );
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.done:
              print('data [${snapshot.hasData}]');
              if (snapshot.hasData) {
                return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: videos.length,
                  itemBuilder: (_, index) =>
                      _buildButton(video: videos.elementAt(index)),
                );
              } else {
                return const Center(
                  child: Text('Error'),
                );
              }
          }
        },
      ),
    );
  }

  Future<void> _refresh() async {
    final newVideos = await _getVideos();

    setState(() {
      videos = newVideos;
    });
  }

  Future<List<String>> _getVideos() async {
    final response = await get(Uri.parse('http://192.168.0.250:8080/videos'));
    return List<String>.from(json.decode(response.body));
    }

  Widget _buildButton({required String video}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: _randomColor()),
      onPressed: () => _requestSong(video),
      child: Text(video),
    );
  }

  MaterialColor _randomColor() =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];

  Future<Response> _requestSong(String video) =>
      get(Uri.parse('http://192.168.0.250:8080/request-video?video=$video'));
}
