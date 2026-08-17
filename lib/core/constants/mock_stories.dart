import '../models/story_model.dart';

class MockStories {
  static final List<Story> sampleStories = [
    const Story(
      id: '1',
      title: 'El ocaso de la República Romana',
      description: 'Un viaje sonoro por los últimos días de la Roma republicana y las guerras civiles.',
      author: 'NoxStories History',
      category: 'Historia Universal',
      subcategory: 'Historia Antigua',
      duration: Duration(minutes: 42, seconds: 15),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      coverUrl: 'https://images.unsplash.com/photo-1552832230-c0197dd311b5?q=80&w=600&auto=format&fit=crop',
    ),
    const Story(
      id: '2',
      title: 'Ragnarök: El fin de los dioses nórdicos',
      description: 'Mitos y profecías de la batalla final entre los dioses de Asgard y los gigantes.',
      author: 'NoxStories Myths',
      category: 'Mitologías del Mundo',
      subcategory: 'Europea',
      duration: Duration(minutes: 35, seconds: 0),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      coverUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=600&auto=format&fit=crop',
    ),
    const Story(
      id: '3',
      title: 'Susurros en el Bosque de las Tinieblas',
      description: 'Leyendas e historias misteriosas documentadas en Europa central.',
      author: 'NoxStories Mystery',
      category: 'Misterio & Otros',
      subcategory: 'Casos Paranormales',
      duration: Duration(minutes: 28, seconds: 40),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      coverUrl: 'https://images.unsplash.com/photo-1509114397022-ed747cca3f65?q=80&w=600&auto=format&fit=crop',
    ),
    const Story(
      id: '4',
      title: 'Lluvia Nocturna en el Valle del Bosque',
      description: 'Paisaje acústico relajante con sonidos naturales en alta definición.',
      author: 'NoxStories Relaxation',
      category: 'Relajación & Meditación',
      subcategory: 'Viajes Sonoros',
      duration: Duration(minutes: 60, seconds: 0),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
      coverUrl: 'https://images.unsplash.com/photo-1511497584788-876761c119ef?q=80&w=600&auto=format&fit=crop',
    ),
  ];
}