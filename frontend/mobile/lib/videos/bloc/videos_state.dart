part of 'videos_bloc.dart';

class VideosState extends Equatable {
  const VideosState({
    this.videos = const [],
  });

  final List<Video> videos;

  VideosState copyWith({
    List<Video>? videos,
  }) {
    return VideosState(
      videos: videos ?? this.videos,
    );
  }

  @override
  List<Object> get props => [videos];
}
