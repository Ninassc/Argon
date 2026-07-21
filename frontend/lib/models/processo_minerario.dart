class ProcessoMinerario {
  final int idProcesso;
  final String idAnm;

  final String processo;
  final String numero;
  final String ano;
  final String areaHa;
  final String fase;
  final String ultEvento;
  // ignore: non_constant_identifier_names
  final String dt_ult_evento;
  final String nome;
  final String subs;
  final String uso;
  final String uf;
  final String dsProcesso;

  const ProcessoMinerario({
    required this.idProcesso,
    required this.idAnm,
    required this.processo,
    required this.numero,
    required this.ano,
    required this.areaHa,
    required this.fase,
    required this.ultEvento,
    // ignore: non_constant_identifier_names
    required this.dt_ult_evento,
    required this.nome,
    required this.subs,
    required this.uso,
    required this.uf,
    required this.dsProcesso,
  });

  factory ProcessoMinerario.fromJson(Map<String, dynamic> json) {
    return ProcessoMinerario(
      idProcesso: json["id_processo"],
      idAnm: json["id_anm"].toString(),

      processo: json["processo"].toString(),
      numero: json["numero"].toString(),
      ano: json["ano"].toString(),
      areaHa: json["area_ha"].toString(),
      fase: json["fase"].toString(),
      ultEvento: json["ult_evento"].toString(),
      dt_ult_evento: json['dt_ult_evento'].toString(),
      nome: json["nome"].toString(),
      subs: json["subs"].toString(),
      uso: json["uso"].toString(),
      uf: json["uf"].toString(),
      dsProcesso: json["ds_processo"].toString(),
    );
  }
}
