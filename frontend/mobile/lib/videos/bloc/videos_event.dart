part of 'videos_bloc.dart';

abstract class VideosEvent extends Equatable {
  const VideosEvent();
}

class VideosFetch extends VideosEvent {
  @override
  List<Object> get props => [];
}

class VideoRequest extends VideosEvent {
  const VideoRequest(this.video);

  final Video video;

  @override
  List<Object> get props => [video];
}
