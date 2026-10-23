class Documento {
  final int idDocumento;
  final int idAtivo;
  final String nomeOriginal;
  final String tipoArquivo;
  final int tamanho;
  final DateTime dtCadastro;

  Documento({
    required this.idDocumento,
    required this.idAtivo,
    required this.nomeOriginal,
    required this.tipoArquivo,
    required this.tamanho,
    required this.dtCadastro,
  });

  factory Documento.fromJson(Map<String, dynamic> json) {
    return Documento(
      idDocumento: json['id_documento'],
      idAtivo: json['id_ativo'],
      nomeOriginal: json['nome_original'],
      tipoArquivo: json['tipo_arquivo'],
      tamanho: json['tamanho'],
      dtCadastro: DateTime.parse(json['dt_cadastro']),
    );
  }
}
