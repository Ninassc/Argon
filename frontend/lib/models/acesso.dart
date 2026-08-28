import 'ativo_minerario.dart';
import 'usuario.dart';

class Acesso {
  final int idAcesso;
  final int idUsuario;
  final int idAtivo;
  final String status;
  final String origem;
  final DateTime? dtSolicitacao;
  final DateTime? dtAcesso;
  final Usuario? usuario;
  final AtivoMinerario? ativo;

  Acesso({
    required this.idAcesso,
    required this.idUsuario,
    required this.idAtivo,
    required this.status,
    required this.origem,
    this.dtSolicitacao,
    this.dtAcesso,
    this.usuario,
    this.ativo,
  });

  factory Acesso.fromJson(Map<String, dynamic> json) {
    return Acesso(
      idAcesso: json["id_acesso"],
      idUsuario: json["id_usuario"],
      idAtivo: json["id_ativo"],
      status: json["status"],
      origem: json["origem"],
      dtSolicitacao: json["dt_solicitacao"] != null
          ? DateTime.parse(json["dt_solicitacao"])
          : null,
      dtAcesso: json["dt_acesso"] != null
          ? DateTime.parse(json["dt_acesso"])
          : null,
      usuario: json["usuario"] != null
          ? Usuario.fromJson(json["usuario"])
          : null,
      ativo: json["ativo"] != null
          ? AtivoMinerario.fromJson(json["ativo"])
          : null,
    );
  }
}
