// lib/telas/FormularioGuilda.dart
import 'package:flutter/material.dart';
import 'package:projeto/Dados/DadosGuilda.dart';
import '../Dados/DadosGuilda.dart';
import '../Modelos/Guilda.dart';

class FormularioGuildaScreen extends StatefulWidget {
  const FormularioGuildaScreen({super.key});

  @override
  State<FormularioGuildaScreen> createState() => _FormularioGuildaScreenState();
}

class _FormularioGuildaScreenState extends State<FormularioGuildaScreen> {
  // 1. Criamos uma "chave" para o nosso formulário
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _tagController = TextEditingController();
  final _servidorController = TextEditingController();
  final _liderController = TextEditingController();

  final Dadosguilda _guildaRepository = Dadosguilda();

  // 2. Criamos uma função de validação genérica
  String? _validadorCampoVazio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo é obrigatório';
    }
    return null;
  }

  void _salvarGuilda() async {
    // 3. Verificamos se o formulário é válido antes de salvar
    if (_formKey.currentState!.validate()) {
      final novaGuilda = Guilda(
        nome: _nomeController.text.trim(),
        tag: _tagController.text.trim(),
        servidor: _servidorController.text.trim(),
        lider: _liderController.text.trim(),
      );

      await _guildaRepository.salvar(novaGuilda);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Nova Guilda'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      // 4. Envolvemos tudo em um widget Form
      body: Form(
        key: _formKey, // Associamos a chave ao formulário
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 5. Trocamos TextField por TextFormField e adicionamos o validador
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome da Guilda'),
                validator: _validadorCampoVazio,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: _tagController,
                decoration: const InputDecoration(labelText: 'Tag (Ex: TDA)'),
                validator: _validadorCampoVazio,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: _servidorController,
                decoration: const InputDecoration(labelText: 'Servidor'),
                validator: _validadorCampoVazio,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: _liderController,
                decoration: const InputDecoration(labelText: 'Líder'),
                validator: _validadorCampoVazio,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarGuilda,
                child: const Text('Salvar Guilda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
