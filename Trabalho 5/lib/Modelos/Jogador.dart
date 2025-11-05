class Jogador {
  final int? id;
  final String nome;
  final int nivel;
  final String classe;
  final String plataforma;
  final int idade;
  final int guildaId; // Chave estrangeira para associar à Guilda

  Jogador({
    this.id,
    required this.nome,
    required this.nivel,
    required this.classe,
    required this.plataforma,
    required this.idade,
    required this.guildaId, // Adicionamos a associação
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'nivel': nivel,
      'classe': classe,
      'plataforma': plataforma,
      'idade': idade,
      'guildaId': guildaId,
    };
  }

  factory Jogador.fromMap(Map<String, dynamic> map) {
    return Jogador(
      id: map['id'],
      nome: map['nome'],
      nivel: map['nivel'],
      classe: map['classe'],
      plataforma: map['plataforma'],
      idade: map['idade'],
      guildaId: map['guildaId'],
    );
  }
}
