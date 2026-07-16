import 'usuario.dart';

class AtivoMinerario {
  final int? idAtivo;
  final int idUsuario;
  final int idProcesso;
  final String descricao;
  final DateTime? dtCadastro;
  final Usuario? usuario;

  const AtivoMinerario({
    this.idAtivo,
    required this.idUsuario,
    required this.idProcesso,
    required this.descricao,
    this.dtCadastro,
    this.usuario,
  });

  factory AtivoMinerario.fromJson(Map<String, dynamic> json) {
    return AtivoMinerario(
      idAtivo: json["id_ativo"],
      idUsuario: json["id_usuario"],
      idProcesso: json["id_processo"],
      descricao: json["descricao"] ?? "",
      dtCadastro: json["dt_cadastro"] != null
          ? DateTime.parse(json["dt_cadastro"])
          : null,
      usuario: json["usuario"] != null
          ? Usuario.fromJson(json["usuario"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_processo": idProcesso,
      "descricao": descricao,
    };
  }
}
