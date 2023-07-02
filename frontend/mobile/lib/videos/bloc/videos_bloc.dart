import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

part 'videos_event.dart';

part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  VideosBloc() : super(const VideosState()) {
    on<VideosFetch>(_onVideosFetch);
  }

  Future<void> _onVideosFetch(
    VideosFetch event,
    Emitter<VideosState> emit,
  ) async {
    final response = await get(Uri.parse('http://192.168.0.250:8080/videos'));

    final videos = (jsonDecode(response.body) as List<dynamic>)
        .map((e) => e as String)
        .map((e) => Video(title: e))
        .toList();

    emit(state.copyWith(videos: videos));
  }
}
