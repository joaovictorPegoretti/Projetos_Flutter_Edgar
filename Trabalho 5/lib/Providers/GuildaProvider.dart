// lib/Providers/GuildaProvider.dart
import 'package:flutter/material.dart';
import '../Modelos/Guilda.dart';
import '../Dados/DadosGuilda.dart';

class GuildaProvider extends ChangeNotifier {
  final Dadosguilda _guildaRepository = Dadosguilda();

  List<Guilda> _guildas = [];
  bool _isLoading = false;

  List<Guilda> get guildas => _guildas;
  bool get isLoading => _isLoading;

  Future<void> carregarGuildas() async {
    _isLoading = true;
    notifyListeners();

    _guildas = await _guildaRepository.listarTodos();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> salvarGuilda(Guilda guilda) async {
    await _guildaRepository.salvar(guilda);
    await carregarGuildas();
  }

  Future<void> atualizarGuilda(Guilda guilda) async {
    await _guildaRepository.update(guilda);
    await carregarGuildas();
  }

  // NOVO: Método para Deletar uma guilda
  Future<void> deletarGuilda(int id) async {
    await _guildaRepository.delete(id);
    await carregarGuildas(); // Recarrega a lista para refletir a exclusão
  }
}
