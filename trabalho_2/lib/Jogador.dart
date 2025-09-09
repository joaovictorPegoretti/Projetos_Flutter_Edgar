class Jogador {
  String nome;
  int nivel;
  String classe;
  String plataforma;
  int idade;

  Jogador(this.nome, this.nivel, this.classe, this.plataforma, this.idade);

  String dadosJogador() {
    return "\n"
        '''
Dados do Jogador: $nome
Nivel: $nivel
Classe: $classe
Plataforma: $plataforma
Idade: $idade
'''
        "\n-------------------------------------";
  }
}
