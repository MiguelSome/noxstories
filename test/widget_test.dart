import 'package:flutter_test/flutter_test.dart';
import 'package:noxstories/main.dart';

void main() {
  testWidgets('Carga inicial de NoxStoriesApp', (WidgetTester tester) async {
    // Construye la aplicación NoxStories y activa un fotograma.
    await tester.pumpWidget(const NoxStoriesApp());

    // Verifica que el título de la aplicación o inicio esté presente.
    expect(find.text('NoxStories'), findsOneWidget);
  });
}