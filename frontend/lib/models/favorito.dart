import 'processo_minerario.dart';

class Favorito {
  final int idFavorito;
  final DateTime? dataFavorito;
  final ProcessoMinerario processo;

  Favorito({
    required this.idFavorito,
    required this.dataFavorito,
    required this.processo,
  });

  factory Favorito.fromJson(Map<String, dynamic> json) {
    return Favorito(
      idFavorito: json["id_favorito"],
      dataFavorito: json["dt_favorito"] != null
          ? DateTime.parse(json["dt_favorito"])
          : null,
      processo: ProcessoMinerario.fromJson(json["processo"]),
    );
  }
}
