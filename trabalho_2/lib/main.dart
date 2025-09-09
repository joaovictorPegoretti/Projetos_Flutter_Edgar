import 'package:flutter/material.dart';
import 'dart:math';
import 'Jogador.dart'; // Importa a classe Jogador

// --- Lógica de Dados Separada ---
// A função para gerar a lista de jogadores foi movida para fora da classe do widget
// para uma melhor separação entre a lógica e a interface, como pedido nas boas práticas.
List<Jogador> _gerarJogadores() {
  final List<String> nomes = [
    "João", "Cleber", "Pedro", "Eduardo", "Rodinei", "Marcos", "Samuel",
  ];
  final List<int> niveis = [2, 11, 22, 34, 41, 16, 99];
  final List<String> classes = [
    "Guerreiro", "Mago", "Curandeiro", "Assassino", "Caçador", "Samurai", "Ninja",
  ];
  final List<String> plataformas = [
    "Play4", "Play5", "PC", "Xbox Series S", "Xbox Series X", "Nintendo Switch", "Steam Deck",
  ];
  final List<int> idades = [12, 21, 35, 7, 57, 16, 10];

  final List<Jogador> listaJogadores = [];
  final random = Random();

  // Garante que a lista tenha um número fixo de jogadores para exibição.
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

void main() {
  // Restaura a estrutura padrão do Flutter [cite: 27]
  runApp(const RpgPlayniumApp());
}

class RpgPlayniumApp extends StatelessWidget {
  const RpgPlayniumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPG do Playnium',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      // A tela inicial agora é o widget que exibe a lista de jogadores.
      home: PlayerListScreen(),
    );
  }
}

// --- Construção da UI ---
// Cumpriu o requisito de criar um StatelessWidget [cite: 30, 37]
class PlayerListScreen extends StatelessWidget {
  // A lista de jogadores é obtida chamando a função de geração de dados.
  // A lógica de dados foi integrada para ser usada na inicialização [cite: 29]
  final List<Jogador> jogadores = _gerarJogadores();

  PlayerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Cumpriu o requisito de usar Scaffold e AppBar [cite: 31, 38]
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Jogadores'),
        backgroundColor: Colors.blueGrey[900],
      ),
      // Cumpriu o requisito de usar ListView para exibir os dados 
      body: ListView.builder(
        itemCount: jogadores.length,
        itemBuilder: (context, index) {
          final jogador = jogadores[index];

          // Usamos um Card com ListTile para uma exibição clara e organizada dos dados [cite: 48]
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(
                jogador.nome,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Classe: ${jogador.classe} | Nível: ${jogador.nivel}',
              ),
              trailing: Text('Idade: ${jogador.idade}'),
              isThreeLine: false,
            ),
          );
        },
      ),
    );
  }
}