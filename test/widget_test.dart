import 'package:flutter_test/flutter_test.dart';

import 'package:dual_sound_controller/main.dart';

void main() {
  testWidgets('Deve exibir a tela inicial do Dual Sound', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DualSoundApp());

    expect(find.text('Dual Sound'), findsOneWidget);
    expect(find.text('Seus dispositivos'), findsOneWidget);
    expect(
      find.text('Nenhum dispositivo conectado'),
      findsOneWidget,
    );
    expect(find.text('Buscar dispositivos'), findsOneWidget);
  });
}