class Guilda {
  final int? id;
  final String nome;
  final String tag;
  final String servidor;
  final String lider; // 5 atributos

  Guilda({
    this.id,
    required this.nome,
    required this.tag,
    required this.servidor,
    required this.lider,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tag': tag,
      'servidor': servidor,
      'lider': lider,
    };
  }

  factory Guilda.fromMap(Map<String, dynamic> map) {
    return Guilda(
      id: map['id'],
      nome: map['nome'],
      tag: map['tag'],
      servidor: map['servidor'],
      lider: map['lider'],
    );
  }
}
