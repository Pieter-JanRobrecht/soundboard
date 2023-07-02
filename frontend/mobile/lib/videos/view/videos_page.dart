import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/videos/videos.dart';
import 'package:mobile/videos/widgets/widgets.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VideosBloc>(
      create: (context) => VideosBloc()..add(VideosFetch()),
      child: const VideosGrid(),
    );
  }
}
