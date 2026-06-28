class ProcessoMinerario {
  final String processo;
  final String numero;
  final String ano;
  final String areaHa;
  final String id;
  final String fase;
  final String ultEvento;
  final String nome;
  final String subs;
  final String uso;
  final String uf;
  final String dsProcesso;

  const ProcessoMinerario({
    required this.processo,
    required this.numero,
    required this.ano,
    required this.areaHa,
    required this.id,
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
      processo: json["PROCESSO"].toString(),
      numero: json["NUMERO"].toString(),
      ano: json["ANO"].toString(),
      areaHa: json["AREA_HA"].toString(),
      id: json["ID"].toString(),
      fase: json["FASE"].toString(),
      ultEvento: json["ULT_EVENTO"].toString(),
      nome: json["NOME"].toString(),
      subs: json["SUBS"].toString(),
      uso: json["USO"].toString(),
      uf: json["UF"].toString(),
      dsProcesso: json["DSProcesso"].toString(),
    );
  }
}
