import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class GridWidget extends StatefulWidget {
  const GridWidget({super.key});

  @override
  State<GridWidget> createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  var videos = [];

  @override
  void initState() {
    super.initState();
    videos = [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getVideos(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? RefreshIndicator(
                  onRefresh: () => _refresh(),
                  child: GridView.builder(
                    primary: false,
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: videos.length,
                    itemBuilder: (_, index) =>
                        _buildButton(video: videos.elementAt(index)),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Future<void> _refresh() async {
    List<String> newVideos = await _getVideos();

    setState(() {
      videos = newVideos;
    });
  }

  Future<List<String>> _getVideos() async {
    final response = await get(Uri.parse("http://192.168.0.250:8080/videos"));
    return List<String>.from(jsonDecode(response.body));
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

  _requestSong(String video) =>
      get(Uri.parse("http://192.168.0.250:8080/request-video?video=$video"));
}
