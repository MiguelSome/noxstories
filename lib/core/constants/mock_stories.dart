import '../models/story_model.dart';

abstract class MockStories {
  static const List<Story> sampleStories = [
    Story(
      id: '1',
      title: 'El Susurro entre las Brumas',
      author: 'Elena Rostova',
      description: 'Una atmósfera envolvente donde antiguos misterios cobran vida bajo la luna llena.',
      coverUrl: 'https://picsum.photos/id/1025/400/400',
      audioUrl: 'https://xgenhpidwwfvxbmusvxm.supabase.co/storage/v1/object/sign/Noxstories/cuento.mp3?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9lNTQ0ZmZhOS0wYTAzLTQzNjUtOTM2MS0zYTk4ODA5YTk2MjIiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJOb3hzdG9yaWVzL2N1ZW50by5tcDMiLCJzY29wZSI6ImRvd25sb2FkIiwiaWF0IjoxNzg2OTgyODk1LCJleHAiOjIxMDIzNDI4OTV9.EHlhx1xl8sn-W5sxOVq0bH4ZQPfBqAgcSB_EL7pDz_I',
      duration: Duration(minutes: 8, seconds: 12),
      category: 'Misterio',
    ),
    Story(
      id: '2',
      title: 'El Mito de Prometeo y el Fuego',
      author: 'Homero Adap.',
      description: 'El titán que desafío a los dioses del Olimpo para entregar la llama del conocimiento a la humanidad.',
      coverUrl: 'https://picsum.photos/id/1040/400/400',
      audioUrl: 'assets/audio/sample1.mp3',
      duration: Duration(minutes: 11, seconds: 05),
      category: 'Mitología',
    ),
    Story(
      id: '3',
      title: 'La Caída de Constantinopla',
      author: 'Marco Valerio',
      description: 'Crónica dramática de las últimas horas del Imperio Bizantino en 1453.',
      coverUrl: 'https://picsum.photos/id/1047/400/400',
      audioUrl: 'assets/audio/sample1.mp3',
      duration: Duration(minutes: 15, seconds: 30),
      category: 'Historia',
    ),
    Story(
      id: '4',
      title: 'Faros en el Infinito',
      author: 'Carlos A. Vance',
      description: 'Un viaje relajante hacia las profundidades del cosmos antes de dormir.',
      coverUrl: 'https://picsum.photos/id/1043/400/400',
      audioUrl: 'assets/audio/sample.mp31',
      duration: Duration(minutes: 12, seconds: 45),
      category: 'Ciencia Ficción',
    ),
    Story(
      id: '5',
      title: 'Meditación para dormir',
      author: 'Gabriela Litschi',
      description: 'Un viaje relajante hacia las profundidades sueño.',
      coverUrl: 'https://picsum.photos/id/1043/400/400',
      audioUrl: 'https://xgenhpidwwfvxbmusvxm.supabase.co/storage/v1/object/sign/Noxstories/meditacion_1.mp3?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9lNTQ0ZmZhOS0wYTAzLTQzNjUtOTM2MS0zYTk4ODA5YTk2MjIiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJOb3hzdG9yaWVzL21lZGl0YWNpb25fMS5tcDMiLCJzY29wZSI6ImRvd25sb2FkIiwiaWF0IjoxNzg2OTg1Nzc3LCJleHAiOjE4NTAwNTc3Nzd9.O5zRhvcgkPSBLK1mGB6xGgzQOlZrSqfNQti7DDA96iw',
      duration: Duration(minutes: 12, seconds: 45),
      category: 'Meditación',
    ),
  ];
}