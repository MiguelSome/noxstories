class Story {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverUrl;
  final String audioUrl;
  final Duration duration;
  final String category;

  const Story({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverUrl,
    required this.audioUrl,
    required this.duration,
    required this.category,
  });
}