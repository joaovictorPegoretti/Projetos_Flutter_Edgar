// test/widget_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// 1. CORREÇÃO: Importa o arquivo 'main.dart' do seu projeto
import 'package:projeto/main.dart';

void main() {
  testWidgets('Smoke test do RpgPlayniumApp', (WidgetTester tester) async {
    // 2. CORREÇÃO: Constrói o seu app 'RpgPlayniumApp' em vez de 'MyApp'
    await tester.pumpWidget(const RpgPlayniumApp());

    // 3. CORREÇÃO: O teste agora verifica se o título na AppBar está correto,
    // em vez de procurar por um contador que não existe no seu app.
    expect(find.text('RPG - Dados Persistentes'), findsOneWidget);

    // Verifica também se o botão de recarregar (FloatingActionButton) existe
    expect(find.byIcon(Icons.refresh), findsOneWidget);
  });
}
