import 'package:equatable/equatable.dart';

/// Video model
class Video extends Equatable {
  /// Constructor
  const Video({
    required this.title,
    this.ytId = '',
  });

  /// from json factory
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      title: json['title'] as String,
      ytId: json['ytId'] as String,
    );
  }

  /// Title of the video
  final String title;

  /// Youtube id of the video
  final String ytId;

  @override
  List<Object?> get props => [title, ytId];
}
