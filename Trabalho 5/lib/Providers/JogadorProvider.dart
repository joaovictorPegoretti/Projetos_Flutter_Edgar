// lib/Providers/JogadorProvider.dart
import 'package:flutter/material.dart';
import '../Modelos/Jogador.dart';
import '../Dados/DadosJogador.dart';

class JogadorProvider extends ChangeNotifier {
  final Dadosjogador _jogadorRepository = Dadosjogador();

  List<Jogador> _jogadores = [];
  bool _isLoading = false;

  // Getters
  List<Jogador> get jogadores => _jogadores;
  bool get isLoading => _isLoading;

  // Carrega todos os jogadores do banco
  Future<void> carregarJogadores() async {
    _isLoading = true;
    notifyListeners(); // Avisa que está carregando

    _jogadores = await _jogadorRepository.listarTodos();

    _isLoading = false;
    notifyListeners(); // Avisa que terminou e entrega os dados
  }

  // Salva um novo jogador e atualiza a lista
  Future<void> salvarJogador(Jogador jogador) async {
    await _jogadorRepository.salvar(jogador);
    await carregarJogadores(); // Recarrega a lista
  }

  // Atualiza um jogador e atualiza a lista
  Future<void> atualizarJogador(Jogador jogador) async {
    await _jogadorRepository.update(jogador);
    await carregarJogadores(); // Recarrega a lista
  }

  // Deleta um jogador e atualiza a lista
  Future<void> deletarJogador(int id) async {
    await _jogadorRepository.delete(id);
    await carregarJogadores(); // Recarrega a lista
  }
}
