// lib/telas/FormularioGuilda.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. IMPORTAR PROVIDER (CORRIGIDO)
import '../Modelos/Guilda.dart';
import '../Providers/GuildaProvider.dart'; // 2. IMPORTAR O NOVO PROVIDER

class FormularioGuildaScreen extends StatefulWidget {
  final Guilda? guilda;
  const FormularioGuildaScreen({super.key, this.guilda});

  @override
  State<FormularioGuildaScreen> createState() => _FormularioGuildaScreenState();
}

class _FormularioGuildaScreenState extends State<FormularioGuildaScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _tagController = TextEditingController();
  final _servidorController = TextEditingController();
  final _liderController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.guilda != null) {
      _isEditing = true;
      final guilda = widget.guilda!;
      _nomeController.text = guilda.nome;
      _tagController.text = guilda.tag;
      _servidorController.text = guilda.servidor;
      _liderController.text = guilda.lider;
    }
  }

  String? _validadorCampoVazio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo é obrigatório';
    }
    return null;
  }

  void _salvarGuilda() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<GuildaProvider>(context, listen: false);

      if (_isEditing) {
        final guildaAtualizada = Guilda(
          id: widget.guilda!.id,
          nome: _nomeController.text.trim(),
          tag: _tagController.text.trim(),
          servidor: _servidorController.text.trim(),
          lider: _liderController.text.trim(),
        );
        await provider.atualizarGuilda(guildaAtualizada);
      } else {
        final novaGuilda = Guilda(
          nome: _nomeController.text.trim(),
          tag: _tagController.text.trim(),
          servidor: _servidorController.text.trim(),
          lider: _liderController.text.trim(),
        );
        await provider.salvarGuilda(novaGuilda);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Guilda' : 'Adicionar Nova Guilda'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                child: Text(_isEditing ? 'Atualizar Guilda' : 'Salvar Guilda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
