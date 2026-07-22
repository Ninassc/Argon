enum TipoConta {
  titular,
  interessado;

  String get descricao {
    switch (this) {
      case TipoConta.titular:
        return "Titular";
      case TipoConta.interessado:
        return "Interessado";
    }
  }
}

class Usuario {
  final int? idUsuario;
  final String nome;
  final String? email;
  final String? telefone;
  final String? senha;
  final TipoConta tipoConta;
  final DateTime? dtCadastro;

  const Usuario({
    this.idUsuario,
    required this.nome,
    this.email,
    this.telefone,
    this.senha,
    required this.tipoConta,
    this.dtCadastro,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      idUsuario: json["id_usuario"],
      nome: json["nome"],
      email: json["email"],
      telefone: json["telefone"],
      tipoConta: json["tipo_conta"] == "Titular"
          ? TipoConta.titular
          : TipoConta.interessado,
      dtCadastro: json["dt_cadastro"] != null
          ? DateTime.parse(json["dt_cadastro"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_usuario": idUsuario,
      "nome": nome,
      "email": email,
      "telefone": telefone,
      "senha": senha,
      "tipo_conta": tipoConta == TipoConta.titular ? "Titular" : "Interessado",
    };
  }
}
