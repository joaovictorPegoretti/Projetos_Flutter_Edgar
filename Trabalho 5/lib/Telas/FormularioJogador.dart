// lib/telas/FormularioJogador.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. IMPORTAR PROVIDER (CORRIGIDO)
import '../Modelos/Jogador.dart';
import '../Providers/GuildaProvider.dart'; // 2. IMPORTAR OS DOIS PROVIDERS
import '../Providers/JogadorProvider.dart';
import 'FormularioGuilda.dart';

class FormularioJogadorScreen extends StatefulWidget {
  final Jogador? jogador;
  const FormularioJogadorScreen({super.key, this.jogador});

  @override
  State<FormularioJogadorScreen> createState() =>
      _FormularioJogadorScreenState();
}

class _FormularioJogadorScreenState extends State<FormularioJogadorScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _nivelController = TextEditingController();
  final _classeController = TextEditingController();
  final _plataformaController = TextEditingController();
  final _idadeController = TextEditingController();

  // 3. REPOSITÓRIOS NÃO SÃO MAIS NECESSÁRIOS AQUI
  // final Dadosjogador _jogadorRepository = Dadosjogador();
  // final Dadosguilda _guildaRepository = Dadosguilda();

  // List<Guilda> _guildas = [];
  // bool _isLoadingGuildas = true;
  int? _selectedGuildaId;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // 4. NÃO PRECISA MAIS CARREGAR GUILDAS AQUI, O PROVIDER FAZ ISSO

    if (widget.jogador != null) {
      _isEditing = true;
      final jogador = widget.jogador!;
      _nomeController.text = jogador.nome;
      _nivelController.text = jogador.nivel.toString();
      _classeController.text = jogador.classe;
      _plataformaController.text = jogador.plataforma;
      _idadeController.text = jogador.idade.toString();
      _selectedGuildaId = jogador.guildaId;
    }
  }

  // 5. FUNÇÃO _carregarGuildas() NÃO É MAIS NECESSÁRIA

  void _abrirFormularioGuilda() async {
    // 6. A NAVEGAÇÃO CONTINUA IGUAL
    // A tela de guilda vai chamar o GuildaProvider, que vai
    // notificar este formulário para atualizar o dropdown.
    await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const FormularioGuildaScreen()),
    );
    // Não precisa mais checar 'foiSalvo == true'
  }

  String? _validadorCampoVazio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo é obrigatório';
    }
    return null;
  }

  String? _validadorCampoNumero(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor, digite um número válido';
    }
    if (int.tryParse(value) == null) {
      return 'Por favor, digite um número válido';
    }
    return null;
  }

  void _salvarJogador() async {
    if (_formKey.currentState!.validate()) {
      // 7. USAR O JOGADOR PROVIDER PARA SALVAR/ATUALIZAR
      final provider = Provider.of<JogadorProvider>(context, listen: false);

      if (_isEditing) {
        final jogadorAtualizado = Jogador(
          id: widget.jogador!.id,
          nome: _nomeController.text.trim(),
          nivel: int.parse(_nivelController.text.trim()),
          classe: _classeController.text.trim(),
          plataforma: _plataformaController.text.trim(),
          idade: int.parse(_idadeController.text.trim()),
          guildaId: _selectedGuildaId!,
        );
        await provider.atualizarJogador(jogadorAtualizado);
      } else {
        final novoJogador = Jogador(
          nome: _nomeController.text.trim(),
          nivel: int.parse(_nivelController.text.trim()),
          classe: _classeController.text.trim(),
          plataforma: _plataformaController.text.trim(),
          idade: int.parse(_idadeController.text.trim()),
          guildaId: _selectedGuildaId!,
        );
        await provider.salvarJogador(novoJogador);
      }

      // 8. APENAS FECHA A TELA
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 9. CONSUMIR O GUILDA PROVIDER PARA OBTER A LISTA DE GUILDAS
    final guildaProvider = Provider.of<GuildaProvider>(context);
    final guildas = guildaProvider.guildas;
    final isLoadingGuildas = guildaProvider.isLoading;

    // Ajusta o ID selecionado se a lista de guildas mudar
    if (_selectedGuildaId != null &&
        !guildas.any((g) => g.id == _selectedGuildaId)) {
      _selectedGuildaId = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Jogador' : 'Adicionar Novo Jogador'),
        backgroundColor: Colors.lightBlue[700],
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ... (Todos os TextFormField (Nome, Nível, etc) continuam iguais)
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
                validator: _validadorCampoNumero,
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
                validator: _validadorCampoNumero,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    // 10. O DROPDOWN AGORA USA OS DADOS DO PROVIDER
                    child: isLoadingGuildas
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : DropdownButtonFormField<int>(
                            decoration: const InputDecoration(
                              labelText: 'Guilda',
                            ),
                            value: _selectedGuildaId,
                            items: guildas.map((guilda) {
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
                child: Text(
                  _isEditing ? 'Atualizar Jogador' : 'Salvar Jogador',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
