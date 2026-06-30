class ProcessoMinerario {
  final int idProcesso;
  final String idAnm;

  final String processo;
  final String numero;
  final String ano;
  final String areaHa;
  final String fase;
  final String ultEvento;
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
      nome: json["nome"].toString(),
      subs: json["subs"].toString(),
      uso: json["uso"].toString(),
      uf: json["uf"].toString(),
      dsProcesso: json["ds_processo"].toString(),
    );
  }
}
