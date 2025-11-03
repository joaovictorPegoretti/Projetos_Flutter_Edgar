// lib/telas/FormularioJogador.dart
import 'package:flutter/material.dart';
import 'package:projeto/Dados/DadosGuilda.dart';
import 'package:projeto/Dados/DadosJogador.dart';
import '../Dados/DadosGuilda.dart';
import '../Dados/DadosJogador.dart';
import '../Modelos/Guilda.dart';
import '../Modelos/Jogador.dart';
import 'FormularioGuilda.dart';

class FormularioJogadorScreen extends StatefulWidget {
  const FormularioJogadorScreen({super.key});

  @override
  State<FormularioJogadorScreen> createState() =>
      _FormularioJogadorScreenState();
}

class _FormularioJogadorScreenState extends State<FormularioJogadorScreen> {
  // 1. Chave para o formulário
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _nivelController = TextEditingController();
  final _classeController = TextEditingController();
  final _plataformaController = TextEditingController();
  final _idadeController = TextEditingController();

  final Dadosjogador _jogadorRepository = Dadosjogador();
  final Dadosguilda _guildaRepository = Dadosguilda();

  List<Guilda> _guildas = [];
  bool _isLoadingGuildas = true;
  int? _selectedGuildaId;

  @override
  void initState() {
    super.initState();
    _carregarGuildas();
  }

  Future<void> _carregarGuildas() async {
    setState(() {
      _isLoadingGuildas = true;
    });
    final guildasDoBanco = await _guildaRepository.listarTodos();
    setState(() {
      _guildas = guildasDoBanco;
      if (_selectedGuildaId != null &&
          !_guildas.any((g) => g.id == _selectedGuildaId)) {
        _selectedGuildaId = null;
      }
      _isLoadingGuildas = false;
    });
  }

  void _abrirFormularioGuilda() async {
    final foiSalvo = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const FormularioGuildaScreen()),
    );
    if (foiSalvo == true) {
      _carregarGuildas();
    }
  }

  // 2. Validadores específicos
  String? _validadorCampoVazio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo é obrigatório';
    }
    return null;
  }

  String? _validadorCampoNumero(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo é obrigatório';
    }
    if (int.tryParse(value) == null) {
      return 'Por favor, digite um número válido';
    }
    return null;
  }

  void _salvarJogador() async {
    // 3. Verificamos se o formulário (incluindo o dropdown) é válido
    if (_formKey.currentState!.validate()) {
      final novoJogador = Jogador(
        nome: _nomeController.text.trim(),
        nivel: int.parse(_nivelController.text.trim()),
        classe: _classeController.text.trim(),
        plataforma: _plataformaController.text.trim(),
        idade: int.parse(_idadeController.text.trim()),
        guildaId: _selectedGuildaId!,
      );
      await _jogadorRepository.salvar(novoJogador);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novo Jogador'),
        backgroundColor: Colors.lightBlue[700],
        foregroundColor: Colors.white,
      ),
      // 4. Envolvemos em um Form
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 5. Usamos TextFormField com os validadores
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: _validadorCampoVazio,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: _nivelController,
                decoration: const InputDecoration(labelText: 'Nível'),
                keyboardType: TextInputType.number,
                validator: _validadorCampoNumero, // Validador de número
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: _classeController,
                decoration: const InputDecoration(labelText: 'Classe'),
                validator: _validadorCampoVazio,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: _plataformaController,
                decoration: const InputDecoration(labelText: 'Plataforma'),
                validator: _validadorCampoVazio,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                controller: _idadeController,
                decoration: const InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.number,
                validator: _validadorCampoNumero, // Validador de número
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _isLoadingGuildas
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        // 6. O DropdownButtonFormField também tem um validador
                        : DropdownButtonFormField<int>(
                            decoration: const InputDecoration(
                              labelText: 'Guilda',
                            ),
                            value: _selectedGuildaId,
                            items: _guildas.map((guilda) {
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
                            validator: (value) {
                              if (value == null) {
                                return 'Selecione uma guilda';
                              }
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Adicionar nova guilda',
                    onPressed: _abrirFormularioGuilda,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarJogador,
                child: const Text('Salvar Jogador'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
