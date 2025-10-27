import 'dart:io';
import '../Trabalho 1/Classe/Jogador.dart';
import 'dart:core';
import 'dart:math';

void main() {
  List<String> nomes = ["João", "Cleber", "Pedro", "Eduardo", "Rodinei", "Marcos", "Samuel"];
  List<int> niveis = [2, 11, 22, 34, 41, 16, 99];
  List<String> classes = ["Guerreiro", "Mago", "Curandeiro", "Assassino", "Caçador", "Samurai", "Ninja"];
  List<String> plataformas = ["Play4", "Play5", "PC", "Xbox Series S", "Xbox Series X", "Nintendo Switch", "Steam Deck"];
  List<int> idades = [12, 21, 35, 7, 57, 16, 10];

  List<Jogador> jogadores = [];
final random = Random();

  // 3. Loop para criar 7 jogadores aleatórios
  for (int i = 0; i < 7; i++) {
    Jogador player = Jogador(
      // Para cada atributo, sorteia um item de sua respectiva lista
      nomes[random.nextInt(nomes.length)],
      niveis[random.nextInt(niveis.length)],
      classes[random.nextInt(classes.length)],
      plataformas[random.nextInt(plataformas.length)],
      idades[random.nextInt(idades.length)],
    );
    jogadores.add(player);
  }
String? resp;
do{
//----Menu
print("-----BEM VINDO AO RPG DO PLAYNIUM-----\n\n");
  print("Escolha uma das opções abaixo:\n");
  print("1- Veja todos os jogadores\n" +
  "2- Veja o jogador com maior e menor nivel\n" +
  "3- Veja se algum jogador tem o mesmo nome\n" +
  "4- Veja qual classe tem mais jogadores\n" +
  "5- Veja quais plataformas mais usadas\n" +
  "6- Veja quais jogadores são adultos, Adolecentes e Crianças\n" +
  "7- Sair");
  print("R: ");
resp = stdin.readLineSync();

 switch(int.tryParse(resp ?? '')){ //Switch com todas as opções do menu, onde cada uma chama uma função para realizar a ação especifica
          case 1:
          resp = todosOsJogadores(jogadores);
          break;

          case 2:
          resp = maioreMenorNivel(jogadores);
          break;

          case 3:
          resp = jogadoresComNomesIguais(jogadores);
          break;

          case 4:
          resp = classeComMaisJogadores(jogadores);
          break;

          case 5:
          resp = plataformascomvariosplayers(jogadores);
          break;

          case 6:
          resp = verificarIdades(jogadores);
          break;

          case 7:
          print("Obrigado por usar o nosso sistema do Playnium\n\n Volte sempre");
          break;

          default: //Caso digite algo sem ser uma das opções, ele informe essa mensagem e retorne ao menu
          print("Opção Invalida, favor inserir novamente");
          break;
        }
}

  while(int.tryParse(resp ?? '') != 7);
  
}

String todosOsJogadores(List<Jogador> jogadores){
  for(Jogador jogador in jogadores){
    jogador.dadosJogador();
  }
  return mensagemFinal(1);
}

  String maioreMenorNivel(List<Jogador> niveis) {
    int MaiorNivel = 0;
    String NomeMaiorNivel = "";
    int MenorNivel = 100;
    String NomeMenorNivel = "";
for(Jogador player in niveis){ //Pecorre todos os jogadores e faz a verificação dos niveis para ser exibido os usuários com maior nível e menor nível
    if(player.nivel > MaiorNivel){
      MaiorNivel = player.nivel;
      NomeMaiorNivel = player.nome;
    }

    if(player.nivel < MenorNivel){
      MenorNivel = player.nivel;
      NomeMenorNivel = player.nome;
    }
}
    print("-----Jogador com maior nivel-----\nNome:$NomeMaiorNivel\nNivel:$MaiorNivel\n\n-----Jogador com menor nivel-----\nNome:$NomeMenorNivel\nNivel:$MenorNivel\n\n");
      return mensagemFinal(2);
  }
  


String jogadoresComNomesIguais(List<Jogador> jogadores) {
  // O Map é usado para estruturar os dados para contar.
  // Chave: nome do jogador (String), Valor: contagem (int).
  Map<String, int> contagemNomes = {};

  // 1. Contar as ocorrências de cada nome na lista de jogadores.
  for (Jogador player in jogadores) {
    contagemNomes[player.nome] = (contagemNomes[player.nome] ?? 0) + 1;
  }

  // 2. Criar um novo mapa para armazenar apenas os nomes que se repetem.
  Map<String, int> nomesRepetidos = {};
  contagemNomes.forEach((nome, contagem) {
    // Se a contagem para um nome for maior que 1, ele é um nome repetido.
    if (contagem > 1) {
      nomesRepetidos[nome] = contagem;
    }
  });

  // 3. Exibir o resultado com base na verificação.
  if (nomesRepetidos.isEmpty) {
    // Se o mapa de nomes repetidos estiver vazio, ninguém se repete.
    print("Entre os 7 jogadores do jogo, nenhum possui o mesmo nome.\n\n");
  } else {
    // Se não estiver vazio, exibe quem se repete e quantas vezes.
    print("Foram encontrados jogadores com nomes repetidos:\n");
    nomesRepetidos.forEach((nome, contagem) {
      print("Nome: $nome\nQuantidade: $contagem vezes\n"
            + "-------------------------------\n");
    });
  }

  return mensagemFinal(3);
}
// Segue a mesma lógica da função {jogadoresComNomesIguais}
  String classeComMaisJogadores(List<Jogador> jogadores){
  
  Map<String, int> contagemClasses = {};

  
  for (Jogador player in jogadores) {
    
    contagemClasses[player.classe] = (contagemClasses[player.classe] ?? 0) + 1;
  }

  
  int maximoJogadores = 0;
  for (int contagem in contagemClasses.values) {
    if (contagem > maximoJogadores) {
      maximoJogadores = contagem;
    }
  }

  if (maximoJogadores <= 1) {
    print("Nenhuma classe tem mais de um jogador.\n\n");
  } 
  else {
    List<String> classesMaisPopulares = [];
    contagemClasses.forEach((classe, contagem) {
      if (contagem == maximoJogadores) {
        classesMaisPopulares.add(classe);
      }
    });

    print("A(s) classe(s) com mais jogadores é(são):\n");
    for (String classe in classesMaisPopulares) {
      print("Classe: $classe\nQuantidade de jogadores: $maximoJogadores\n");
    }
  }

  return mensagemFinal(4);
}
// Segue a mesma lógica da função {jogadoresComNomesIguais}
String plataformascomvariosplayers(List<Jogador> jogadores){

  Map<String, int> contagemPlataformas = {};

  
  for (Jogador player in jogadores) {
    
    contagemPlataformas[player.plataforma] = (contagemPlataformas[player.plataforma] ?? 0) + 1;
  }

  
  int maximoJogadores = 0;
  for (int contagem in contagemPlataformas.values) {
    if (contagem > maximoJogadores) {
      maximoJogadores = contagem;
    }
  }

  
  if (maximoJogadores <= 1) {
    print("Nenhuma plataforma tem mais de um jogador.\n\n");
  } 
  else {
   
    List<String> plataformasMaisPopulares = [];
    contagemPlataformas.forEach((plataforma, contagem) {
      if (contagem == maximoJogadores) {
        plataformasMaisPopulares.add(plataforma);
      }
    });

    
    print("A(s) plataforma(s) com mais jogadores é(são):\n");
    for (String classe in plataformasMaisPopulares) {
      print("Plataforma: $classe\nQuantidade de jogadores: $maximoJogadores\n");
    }
  }

  return mensagemFinal(5);
}
// Função para verificar a idade dos jogadores
String verificarIdades(List<Jogador> idades) {
List<String> jogadoresAdultos = [];
List<String> jogadoresAdolecentes = [];
List<String> jogadoresCriancas = [];
for(Jogador player in idades){ //Ao percorrer todos os jogadores, ele verifica as idades e adiciona na lista recorrente a sua idade
if(player.idade >= 18){
  jogadoresAdultos.add(player.nome);
}
else if (player.idade < 18 && player.idade > 12){
  jogadoresAdolecentes.add(player.nome);
}
else{
  jogadoresCriancas.add(player.nome);
}
}

if(jogadoresAdultos.length > 0){
  print("\nOs jogadores $jogadoresAdultos\nSão adultos\n");
}
else{
  print("\nNenhum jogador é adulto\n");
}

if(jogadoresAdolecentes.length > 0){
  print("\nOs jogadores $jogadoresAdolecentes\nSão adolecentes\n");
}
else{
  print("\nNenhum jogador é adolecente\n");
}

if(jogadoresCriancas.length > 0){
  print("\nOs jogadores $jogadoresCriancas\nSão crianças\n");
}
else{
  print("\nNenhum jogador é criança\n");
}

return mensagemFinal(6);

}
  // Função para ao final de cada função ser feito a pergunta se deseja voltar ao menu
  String mensagemFinal( int opcao){
    print("Deseja retornar ao menu?[y|n]");
    String? resp = stdin.readLineSync();
    if(resp == "n" || resp == "N"){
      print("Muito obrigado por usar o Playnium!");
return "7";
    }
    else{
      return "$opcao";
    }
  }


