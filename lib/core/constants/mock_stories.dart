import '../models/story_model.dart';

abstract class MockStories {
  static const List<Story> sampleStories = [
    Story(
      id: '1',
      title: 'El Susurro entre las Brumas',
      author: 'Elena Rostova',
      description: 'Una atmósfera envolvente donde antiguos misterios cobran vida bajo la luna llena.',
      coverUrl: 'https://picsum.photos/id/1025/400/400',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      duration: Duration(minutes: 8, seconds: 12),
      category: 'Misterio',
    ),
    Story(
      id: '2',
      title: 'Faros en el Infinito',
      author: 'Carlos A. Vance',
      description: 'Un viaje relajante hacia las profundidades del cosmos antes de dormir.',
      coverUrl: 'https://picsum.photos/id/1043/400/400',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      duration: Duration(minutes: 12, seconds: 45),
      category: 'Ciencia Ficción',
    ),
  ];
}