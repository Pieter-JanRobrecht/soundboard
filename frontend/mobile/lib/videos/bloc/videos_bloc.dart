import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';

part 'videos_event.dart';

part 'videos_state.dart';

const _baseUrl = 'http://192.168.0.250:8080';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  VideosBloc() : super(const VideosState()) {
    on<VideosFetch>(_onVideosFetch);
    on<VideoRequest>(_onVideoRequest);
  }

  Future<void> _onVideosFetch(
    VideosFetch event,
    Emitter<VideosState> emit,
  ) async {
    final response = await get(Uri.parse('$_baseUrl/videos'));

    final videos = (jsonDecode(response.body) as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(Video.fromJson)
        .toList();

    emit(state.copyWith(videos: videos));
  }

  Future<void> _onVideoRequest(
    VideoRequest event,
    Emitter<VideosState> emit,
  ) async {
    final video = event.video;
    await get(Uri.parse('$_baseUrl/request-video?video=${video.ytId}'));
  }
}
