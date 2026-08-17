import '../models/story_model.dart';

abstract class MockStories {
  static const List<Story> sampleStories = [
    Story(
      id: '1',
      title: 'El Susurro entre las Brumas',
      author: 'Elena Rostova',
      description: 'Una atmósfera envolvente donde antiguos misterios cobran vida bajo la luna llena.',
      coverUrl: 'https://picsum.photos/id/1025/400/400',
      audioUrl: 'assets/audio/sample.mp3',
      duration: Duration(minutes: 8, seconds: 12),
      category: 'Misterio',
    ),
    Story(
      id: '2',
      title: 'El Mito de Prometeo y el Fuego',
      author: 'Homero Adap.',
      description: 'El titán que desafío a los dioses del Olimpo para entregar la llama del conocimiento a la humanidad.',
      coverUrl: 'https://picsum.photos/id/1040/400/400',
      audioUrl: 'assets/audio/sample.mp3',
      duration: Duration(minutes: 11, seconds: 05),
      category: 'Mitología',
    ),
    Story(
      id: '3',
      title: 'La Caída de Constantinopla',
      author: 'Marco Valerio',
      description: 'Crónica dramática de las últimas horas del Imperio Bizantino en 1453.',
      coverUrl: 'https://picsum.photos/id/1047/400/400',
      audioUrl: 'assets/audio/sample.mp3',
      duration: Duration(minutes: 15, seconds: 30),
      category: 'Historia',
    ),
    Story(
      id: '4',
      title: 'Faros en el Infinito',
      author: 'Carlos A. Vance',
      description: 'Un viaje relajante hacia las profundidades del cosmos antes de dormir.',
      coverUrl: 'https://picsum.photos/id/1043/400/400',
      audioUrl: 'assets/audio/sample.mp3',
      duration: Duration(minutes: 12, seconds: 45),
      category: 'Ciencia Ficción',
    ),
  ];
}