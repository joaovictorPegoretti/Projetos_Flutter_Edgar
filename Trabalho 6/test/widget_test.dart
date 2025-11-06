import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:projeto/Banco/Config.dart';
import 'package:projeto/Providers/GuildaProvider.dart';
import 'package:projeto/Providers/JogadorProvider.dart';
import 'package:projeto/Telas/TelaListagemGuildas.dart';
import 'package:projeto/Telas/FormularioGuilda.dart';

void main() {
  // Configuração do banco de dados em memória para os testes
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    await Banco.instance.initTestDatabase();
  });

  tearDown(() async {
    await Banco.instance.close();
  });

  // Função auxiliar para injetar os Providers necessários nos widgets de teste
  Widget criarWidgetDeTeste(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GuildaProvider()),
        ChangeNotifierProvider(create: (_) => JogadorProvider()),
      ],
      child: MaterialApp(home: child),
    );
  }

  testWidgets('Deve exibir mensagem de vazio na lista de guildas', (
    WidgetTester tester,
  ) async {
    // 1. Carrega a tela de listagem com banco vazio
    await tester.pumpWidget(criarWidgetDeTeste(const TelaListagemGuildas()));
    // 2. Espera o Flutter desenhar todos os quadros
    await tester.pumpAndSettle();

    // 3. Verifica se o texto esperado está na tela
    expect(
      find.text('Nenhuma guilda encontrada. Adicione uma nova!'),
      findsOneWidget,
    );
    // 4. Verifica se NÃO existe nenhum item de lista (pois está vazio)
    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('Deve permitir digitar no formulário de guilda', (
    WidgetTester tester,
  ) async {
    // 1. Carrega o formulário
    await tester.pumpWidget(criarWidgetDeTeste(const FormularioGuildaScreen()));
    await tester.pumpAndSettle();

    // 2. Encontra o campo de texto "Nome da Guilda"
    final campoNome = find.widgetWithText(TextFormField, 'Nome da Guilda');
    expect(campoNome, findsOneWidget);

    // 3. Simula a digitação
    await tester.enterText(campoNome, 'Guilda de Teste Widget');
    await tester.pump();

    // 4. Verifica se o texto foi inserido corretamente
    expect(find.text('Guilda de Teste Widget'), findsOneWidget);
  });
}
