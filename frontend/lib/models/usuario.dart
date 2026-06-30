class Usuario {
  final int? idUsuario;
  final String nome;
  final String? email;
  final String? telefone;
  final String? senha;
  final DateTime? dtCadastro;

  const Usuario({
    this.idUsuario,
    required this.nome,
    this.email,
    this.telefone,
    this.senha,
    this.dtCadastro,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      idUsuario: json["id_usuario"],
      nome: json["nome"],
      email: json["email"],
      telefone: json["telefone"],
      dtCadastro: json["dt_cadastro"] != null
          ? DateTime.parse(json["dt_cadastro"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {"nome": nome, "email": email, "telefone": telefone, "senha": senha};
  }
}
