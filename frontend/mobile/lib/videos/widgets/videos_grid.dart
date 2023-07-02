import 'dart:math';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/videos/videos.dart';

class VideosGrid extends StatelessWidget {
  const VideosGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<VideosBloc>().add(VideosFetch()),
      child: BlocBuilder<VideosBloc, VideosState>(
        builder: (context, state) {
          return GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: state.videos.length,
            itemBuilder: (_, index) => _VideoButton(video: state.videos[index]),
          );
        },
      ),
    );
  }
}

class _VideoButton extends StatelessWidget {
  const _VideoButton({required this.video});

  final Video video;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: _randomColor()),
      onPressed: () => context.read<VideosBloc>().add(VideoRequest(video)),
      child: Text(video.title),
    );
  }

  MaterialColor _randomColor() =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
}
