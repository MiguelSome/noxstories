class Story {
  final String id;
  final String title;
  final String description;
  final String author;
  final String category;
  final String subcategory;
  final Duration duration;
  final String audioUrl;
  final String coverUrl;

  const Story({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.category,
    this.subcategory = '',
    required this.duration,
    required this.audioUrl,
    required this.coverUrl,
  });

  Story copyWith({
    String? id,
    String? title,
    String? description,
    String? author,
    String? category,
    String? subcategory,
    Duration? duration,
    String? audioUrl,
    String? coverUrl,
  }) {
    return Story(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      author: author ?? this.author,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      duration: duration ?? this.duration,
      audioUrl: audioUrl ?? this.audioUrl,
      coverUrl: coverUrl ?? this.coverUrl,
    );
  }
}