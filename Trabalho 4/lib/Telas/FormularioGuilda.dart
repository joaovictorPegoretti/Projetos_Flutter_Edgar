// lib/telas/FormularioGuilda.dart
import 'package:flutter/material.dart';
import '../Dados/DadosGuilda.dart';
import '../Modelos/Guilda.dart';

class FormularioGuildaScreen extends StatefulWidget {
  const FormularioGuildaScreen({super.key});

  @override
  State<FormularioGuildaScreen> createState() => _FormularioGuildaScreenState();
}

class _FormularioGuildaScreenState extends State<FormularioGuildaScreen> {
  // Controladores para os campos de texto
  final _nomeController = TextEditingController();
  final _tagController = TextEditingController();
  final _servidorController = TextEditingController();
  final _liderController = TextEditingController();

  final Dadosguilda _guildaRepository = Dadosguilda();

  void _salvarGuilda() async {
    final novaGuilda = Guilda(
      nome: _nomeController.text,
      tag: _tagController.text,
      servidor: _servidorController.text,
      lider: _liderController.text,
    );

    await _guildaRepository.salvar(novaGuilda);

    // Fecha a tela e avisa a tela anterior que um item foi salvo
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Nova Guilda'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome da Guilda'),
            ),
            TextField(
              controller: _tagController,
              decoration: const InputDecoration(labelText: 'Tag (Ex: TDA)'),
            ),
            TextField(
              controller: _servidorController,
              decoration: const InputDecoration(labelText: 'Servidor'),
            ),
            TextField(
              controller: _liderController,
              decoration: const InputDecoration(labelText: 'Líder'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarGuilda,
              child: const Text('Salvar Guilda'),
            ),
          ],
        ),
      ),
    );
  }
}
