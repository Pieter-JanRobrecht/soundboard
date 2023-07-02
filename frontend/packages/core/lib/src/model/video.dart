import 'package:equatable/equatable.dart';

/// Video model
class Video extends Equatable {
  /// Constructor
  const Video({
    required this.title,
    this.ytID = '',
  });

  /// Title of the video
  final String title;

  /// Youtube id of the video
  final String ytID;

  @override
  List<Object?> get props => [title, ytID];
}
