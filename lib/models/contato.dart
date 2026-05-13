class Contato {
  final int? id;
  final String nome;
  final int numeroConta;

  Contato({this.id, required this.nome, required this.numeroConta});

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'numero_conta': numeroConta,
    };
  }
}