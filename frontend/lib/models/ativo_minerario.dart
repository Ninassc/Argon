import 'usuario.dart';
import 'processo_minerario.dart';

class AtivoMinerario {
  final int? idAtivo;
  final int? idUsuario;
  final int idProcesso;
  final String descricao;
  final DateTime? dtCadastro;
  final Usuario? usuario;
  final ProcessoMinerario? processoMinerario;

  const AtivoMinerario({
    this.idAtivo,
    this.idUsuario,
    required this.idProcesso,
    required this.descricao,
    this.dtCadastro,
    this.usuario,
    this.processoMinerario,
  });

  factory AtivoMinerario.fromJson(Map<String, dynamic> json) {
    return AtivoMinerario(
      idAtivo: json["id_ativo"],
      idUsuario: json["id_usuario"],
      idProcesso: json["processo"] != null
          ? json["processo"]["id_processo"]
          : json["id_processo"],
      descricao: json["descricao"] ?? "",
      dtCadastro: json["dt_cadastro"] != null
          ? DateTime.parse(json["dt_cadastro"])
          : null,
      usuario: json["usuario"] != null
          ? Usuario.fromJson(json["usuario"])
          : null,
      processoMinerario: json["processo"] != null
          ? ProcessoMinerario.fromJson(json["processo"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {"id_processo": idProcesso, "descricao": descricao};
  }
}
