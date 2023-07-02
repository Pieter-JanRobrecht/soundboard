part of 'videos_bloc.dart';

abstract class VideosEvent extends Equatable {
  const VideosEvent();
}

class VideosFetch extends VideosEvent {
  @override
  List<Object> get props => [];
}
