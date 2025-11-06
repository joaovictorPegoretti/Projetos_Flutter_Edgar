import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:projeto/Banco/Config.dart';
import 'package:projeto/Modelos/Guilda.dart';
import 'package:projeto/Dados/DadosGuilda.dart';

void main() {
  // Configura o ambiente de teste para usar SQLite em memória
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  // Antes de CADA teste, cria um banco novo e limpo
  setUp(() async {
    await Banco.instance.initTestDatabase();
  });

  // Depois de CADA teste, fecha o banco
  tearDown(() async {
    await Banco.instance.close();
  });

  group('Testes Unitários de Guilda', () {
    final repo = Dadosguilda();

    test('Deve salvar e listar uma guilda', () async {
      final guilda = Guilda(
        nome: 'Test Guild',
        tag: 'TG',
        servidor: 'BR',
        lider: 'Tester',
      );
      final id = await repo.salvar(guilda);

      // Verifica se o ID gerado é válido (maior que 0)
      expect(id, greaterThan(0));

      final lista = await repo.listarTodos();
      // Verifica se salvou exatamente 1 guilda
      expect(lista.length, 1);
      // Verifica se os dados estão corretos
      expect(lista.first.nome, 'Test Guild');
    });

    test('Deve atualizar uma guilda', () async {
      // 1. Salva a guilda original
      final id = await repo.salvar(
        Guilda(nome: 'Original', tag: 'OG', servidor: 'US', lider: 'Old'),
      );

      // 2. Atualiza a guilda mantendo o MESMO ID
      await repo.update(
        Guilda(
          id: id,
          nome: 'Editado',
          tag: 'ED',
          servidor: 'US',
          lider: 'New',
        ),
      );

      // 3. Verifica se mudou
      final lista = await repo.listarTodos();
      expect(lista.first.nome, 'Editado');
      expect(lista.first.lider, 'New');
    });

    test('Deve deletar uma guilda', () async {
      // 1. Salva
      final id = await repo.salvar(
        Guilda(nome: 'Delete Me', tag: 'DM', servidor: 'BR', lider: 'Temp'),
      );
      // 2. Deleta
      await repo.delete(id);

      // 3. Verifica se a lista está vazia
      final lista = await repo.listarTodos();
      expect(lista, isEmpty);
    });
  });
}
