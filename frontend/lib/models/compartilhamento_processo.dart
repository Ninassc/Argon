import 'usuario.dart';
import 'processo_minerario.dart';

class CompartilhamentoProcesso {
  final int idCompartilhamento;
  final DateTime? dtCompartilhamento;
  final Usuario usuarioOrigem;
  final Usuario usuarioDestino;
  final ProcessoMinerario processo;

  CompartilhamentoProcesso({
    required this.idCompartilhamento,
    required this.dtCompartilhamento,
    required this.usuarioOrigem,
    required this.usuarioDestino,
    required this.processo,
  });

  factory CompartilhamentoProcesso.fromJson(
    Map<String, dynamic> json,
  ) {
    return CompartilhamentoProcesso(
      idCompartilhamento: json["id_compartilhamento"],
      dtCompartilhamento: json["dt_compartilhamento"] != null
          ? DateTime.parse(json["dt_compartilhamento"])
          : null,
      usuarioOrigem: Usuario.fromJson(json["usuario_origem"]),
      usuarioDestino: Usuario.fromJson(json["usuario_destino"]),
      processo: ProcessoMinerario.fromJson(json["processo"]),
    );
  }
}