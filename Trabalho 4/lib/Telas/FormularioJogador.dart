// lib/telas/FormularioJogador.dart
import 'package:flutter/material.dart';
import '../Dados/DadosGuilda.dart';
import '../Dados/DadosJogador.dart';
import '../Modelos/Guilda.dart';
import '../Modelos/Jogador.dart';

class FormularioJogadorScreen extends StatefulWidget {
  const FormularioJogadorScreen({super.key});

  @override
  State<FormularioJogadorScreen> createState() =>
      _FormularioJogadorScreenState();
}

class _FormularioJogadorScreenState extends State<FormularioJogadorScreen> {
  // Controladores para pegar o texto dos campos do formulário
  final _nomeController = TextEditingController();
  final _nivelController = TextEditingController();
  final _classeController = TextEditingController();
  final _plataformaController = TextEditingController();
  final _idadeController = TextEditingController();

  final Dadosjogador _jogadorRepository = Dadosjogador();
  final Dadosguilda _guildaRepository = Dadosguilda();

  late Future<List<Guilda>> _guildasFuture;
  int? _selectedGuildaId; // Armazena o ID da guilda selecionada no dropdown

  @override
  void initState() {
    super.initState();
    // Carrega as guildas existentes para exibir no dropdown
    _guildasFuture = _guildaRepository.listarTodos();
  }

  // Função para salvar o novo jogador
  void _salvarJogador() async {
    if (_selectedGuildaId == null) {
      // Mostra um erro se nenhuma guilda for selecionada
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecione uma guilda!')),
      );
      return;
    }

    final novoJogador = Jogador(
      nome: _nomeController.text,
      nivel: int.parse(_nivelController.text),
      classe: _classeController.text,
      plataforma: _plataformaController.text,
      idade: int.parse(_idadeController.text),
      guildaId: _selectedGuildaId!,
    );

    await _jogadorRepository.salvar(novoJogador);

    // Fecha a tela de formulário e retorna 'true' para a tela anterior
    // indicando que a lista deve ser atualizada.
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novo Jogador'),
        backgroundColor: Colors.lightBlue[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _nivelController,
              decoration: const InputDecoration(labelText: 'Nível'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _classeController,
              decoration: const InputDecoration(labelText: 'Classe'),
            ),
            TextField(
              controller: _plataformaController,
              decoration: const InputDecoration(labelText: 'Plataforma'),
            ),
            TextField(
              controller: _idadeController,
              decoration: const InputDecoration(labelText: 'Idade'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Dropdown para selecionar a Guilda
            FutureBuilder<List<Guilda>>(
              future: _guildasFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return DropdownButtonFormField<int>(
                  decoration: const InputDecoration(labelText: 'Guilda'),
                  value: _selectedGuildaId,
                  items: snapshot.data!.map((guilda) {
                    return DropdownMenuItem<int>(
                      value: guilda.id,
                      child: Text(guilda.nome),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGuildaId = value;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarJogador,
              child: const Text('Salvar Jogador'),
            ),
          ],
        ),
      ),
    );
  }
}
