import 'package:flutter/material.dart';
import 'dart:math';
import 'Jogador.dart'; // Importa a classe Jogador

void main() {
  runApp(const RpgPlayniumApp());
}

class RpgPlayniumApp extends StatelessWidget {
  const RpgPlayniumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPG do Playnium',
      theme: ThemeData(primarySwatch: Colors.lightBlue, useMaterial3: true),
      home: const MenuScreen(), // A tela inicial é o menu
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // A lista de jogadores é gerada uma vez e armazenada no estado
  late List<Jogador> jogadores;

  @override
  void initState() {
    super.initState();
    jogadores = _gerarJogadores();
  }

  // A lógica de geração de jogadores
  List<Jogador> _gerarJogadores() {
    final List<String> nomes = [
      "João",
      "Cleber",
      "Pedro",
      "Eduardo",
      "Rodinei",
      "Marcos",
      "Samuel",
    ];
    final List<int> niveis = [2, 11, 22, 34, 41, 16, 99];
    final List<String> classes = [
      "Guerreiro",
      "Mago",
      "Curandeiro",
      "Assassino",
      "Caçador",
      "Samurai",
      "Ninja",
    ];
    final List<String> plataformas = [
      "Play4",
      "Play5",
      "PC",
      "Xbox Series S",
      "Xbox Series X",
      "Nintendo Switch",
      "Steam Deck",
    ];
    final List<int> idades = [12, 21, 35, 7, 57, 16, 10];

    final List<Jogador> listaJogadores = [];
    final random = Random();

    for (int i = 0; i < 7; i++) {
      listaJogadores.add(
        Jogador(
          nomes[random.nextInt(nomes.length)],
          niveis[random.nextInt(niveis.length)],
          classes[random.nextInt(classes.length)],
          plataformas[random.nextInt(plataformas.length)],
          idades[random.nextInt(idades.length)],
        ),
      );
    }
    return listaJogadores;
  }

  // --- Funções de Lógica Adaptadas ---

  String _todosOsJogadores() {
    // Usamos um StringBuffer para construir a string de forma eficiente
    final buffer = StringBuffer();
    for (final jogador in jogadores) {
      buffer.writeln('Nome: ${jogador.nome}');
      buffer.writeln('Nível: ${jogador.nivel}');
      buffer.writeln('Classe: ${jogador.classe}');
      buffer.writeln('Plataforma: ${jogador.plataforma}');
      buffer.writeln('Idade: ${jogador.idade}');
      buffer.writeln('--------------------');
    }
    return buffer.toString();
  }

  String _maiorEMenorNivel() {
    if (jogadores.isEmpty) return "Nenhum jogador encontrado.";

    Jogador maior = jogadores.first;
    Jogador menor = jogadores.first;

    //for para pecorrer todos os jogadores e verificar quais jogadores tem o maior e menor nível
    for (final jogador in jogadores) {
      if (jogador.nivel > maior.nivel) maior = jogador;
      if (jogador.nivel < menor.nivel) menor = jogador;
    }

    return 'Jogador com maior nível:\n'
        'Nome: ${maior.nome} (Nível: ${maior.nivel})\n\n'
        'Jogador com menor nível:\n'
        'Nome: ${menor.nome} (Nível: ${menor.nivel})';
  }

  String _nomesIguais() {
    final contagem = <String, int>{};

    for (final jogador in jogadores) {
      contagem[jogador.nome] = (contagem[jogador.nome] ?? 0) + 1;
    }

    final repetidos = contagem.entries.where((entry) => entry.value > 1);
    // Parte que organiza os nomes em grupos para saber quais os nomes que os jogadores tem igual
    if (repetidos.isEmpty) {
      return "Nenhum jogador possui o mesmo nome.";
    }

    return repetidos
        .map((e) => 'Nome: ${e.key}, Quantidade: ${e.value}')
        .join('\n');
  }

  String _classeComMaisJogadores() {
    final contagem = <String, int>{};
    //For para analisar todas as classes que cada jogador tem
    for (var jogador in jogadores) {
      contagem[jogador.classe] = (contagem[jogador.classe] ?? 0) + 1;
    }

    // Parte que organiza as classes em grupos para saber quais as classes que tem mais jogadores
    if (contagem.isEmpty) return "Nenhuma classe encontrada.";

    final maxJogadores = contagem.values.reduce(max);

    if (maxJogadores <= 1) return "Nenhuma classe tem mais de um jogador.";

    final populares = contagem.entries.where((e) => e.value == maxJogadores);

    return populares
        .map((e) => 'Classe: ${e.key}\nJogadores: $maxJogadores')
        .join('\n\n');
  }

  String _plataformasMaisUsadas() {
    final contagem = <String, int>{};
    //For para analisar todas as plataformas que cada jogador tem
    for (var jogador in jogadores) {
      contagem[jogador.plataforma] = (contagem[jogador.plataforma] ?? 0) + 1;
    }

    // Parte que organiza as plataformas em grupos para saber quais plataformas tem mais jogadores
    if (contagem.isEmpty) return "Nenhuma plataforma encontrada.";

    final maxJogadores = contagem.values.reduce(max);

    if (maxJogadores <= 1) return "Nenhuma plataforma tem mais de um jogador.";

    final populares = contagem.entries.where((e) => e.value == maxJogadores);

    return populares
        .map((e) => 'Plataforma: ${e.key}\nJogadores: $maxJogadores')
        .join('\n\n');
  }

  String _verificarIdades() {
    // Condições para verificar e separar os jogadores pelas suas idades
    final criancas = jogadores
        .where((j) => j.idade < 12)
        .map((j) => j.nome)
        .join(', ');
    final adolescentes = jogadores
        .where((j) => j.idade >= 12 && j.idade < 18)
        .map((j) => j.nome)
        .join(', ');
    final adultos = jogadores
        .where((j) => j.idade >= 18)
        .map((j) => j.nome)
        .join(', ');
    // Aqui faz o retorno com os jogadores separados, caso um grupo não tenha nenhum jogador irá aparecer escrito "Nehuma"
    return 'Crianças: ${criancas.isNotEmpty ? criancas : "Nenhuma"}\n\n'
        'Adolescentes: ${adolescentes.isNotEmpty ? adolescentes : "Nenhum"}\n\n'
        'Adultos: ${adultos.isNotEmpty ? adultos : "Nenhum"}';
  }

  // Função para exibir o diálogo
  void _showResultDialog(String title, String content) {
    showDialog(
      // Ao o usuário clicar nas opções do menu, irá abrir uma caixa de alerta e irá mostrar os resultados da função desiginada para aquela opção
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(child: Text(content)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Adicione esta função dentro da classe _MenuScreenState

  void _regenerarJogadores() {
    setState(() {
      // A chamada para setState notifica o Flutter que o estado mudou,
      // fazendo com que a UI seja reconstruída com a nova lista.
      jogadores = _gerarJogadores();
    });
  }

  @override
  //Aqui é a estrutura da página de Menu, onde irá mostrar todas as opções e seus icones
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RPG do Playnium - Menu'),
        backgroundColor: Colors.lightBlue[700],
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(
              Icons.group,
            ), // Aqui usamos icones já disponiveis pelo proprio flutter
            title: const Text('Ver todos os jogadores'),
            onTap: () =>
                _showResultDialog('Todos os Jogadores', _todosOsJogadores()),
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Jogador com maior e menor nível'),
            onTap: () =>
                _showResultDialog('Maior e Menor Nível', _maiorEMenorNivel()),
          ),
          ListTile(
            leading: const Icon(Icons.control_point_duplicate),
            title: const Text('Verificar nomes repetidos'),
            onTap: () => _showResultDialog('Nomes Repetidos', _nomesIguais()),
          ),
          ListTile(
            leading: const Icon(Icons.shield),
            title: const Text('Classe com mais jogadores'),
            onTap: () => _showResultDialog(
              'Classes Mais Populares',
              _classeComMaisJogadores(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.gamepad),
            title: const Text('Plataformas mais usadas'),
            onTap: () => _showResultDialog(
              'Plataformas Mais Usadas',
              _plataformasMaisUsadas(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_search),
            title: const Text('Verificar idades'),
            onTap: () => _showResultDialog(
              'Faixa Etária dos Jogadores',
              _verificarIdades(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _regenerarJogadores, // Chama a nova função
        tooltip: 'Gerar novos jogadores',
        child: const Icon(Icons.refresh), // Ícone de atualização
      ),
    );
  }
}
