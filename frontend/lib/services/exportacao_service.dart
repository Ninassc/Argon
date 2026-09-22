import 'package:excel/excel.dart';
import 'package:frontend/models/processo_minerario.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_selector/file_selector.dart';
import 'dart:typed_data';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

class ExportacaoService {
  List<int>? gerarPlanilha(ProcessoMinerario processo) {
    final excel = Excel.createExcel();

    final planilha = excel['Processo Minerário'];

    planilha.appendRow([
      TextCellValue('Processo'),
      TextCellValue('Número'),
      TextCellValue('Ano'),
      TextCellValue('Área (ha)'),
      TextCellValue('Fase'),
      TextCellValue('Último evento'),
      TextCellValue('Data do último evento'),
      TextCellValue('Nome'),
      TextCellValue('Substância'),
      TextCellValue('Uso'),
      TextCellValue('UF'),
      TextCellValue('Descrição do processo'),
      TextCellValue('ID ANM'),
    ]);

    planilha.appendRow([
      TextCellValue(processo.processo),
      TextCellValue(processo.numero),
      TextCellValue(processo.ano),
      TextCellValue(processo.areaHa),
      TextCellValue(processo.fase),
      TextCellValue(processo.ultEvento),
      TextCellValue(processo.dt_ult_evento),
      TextCellValue(processo.nome),
      TextCellValue(processo.subs),
      TextCellValue(processo.uso),
      TextCellValue(processo.uf),
      TextCellValue(processo.dsProcesso),
      TextCellValue(processo.idAnm),
    ]);

    excel.delete('Sheet1');

    return excel.encode();
  }

  Future<void> compartilharPlanilha(ProcessoMinerario processo) async {
    final bytes = gerarPlanilha(processo);

    if (bytes == null) {
      throw Exception("Não foi possível gerar a planilha.");
    }

    final diretorio = await getTemporaryDirectory();

    final nomeProcesso = processo.processo
        .replaceAll('/', '-')
        .replaceAll(' ', '_');

    final arquivo = File('${diretorio.path}/processo_$nomeProcesso.xlsx');

    await arquivo.writeAsBytes(bytes);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(arquivo.path)],
        text: 'Dados do processo minerário ${processo.processo}.',
        subject: 'Processo minerário ${processo.processo}',
      ),
    );
  }

  Future<String?> salvarPlanilha(ProcessoMinerario processo) async {
    final bytes = gerarPlanilha(processo);

    if (bytes == null) {
      throw Exception("Não foi possível gerar a planilha.");
    }

    final diretorioTemporario = await getTemporaryDirectory();

    final nomeProcesso = processo.processo
        .replaceAll('/', '-')
        .replaceAll(' ', '_');

    final nomeArquivo = 'processo_$nomeProcesso.xlsx';

    final arquivoTemporario = File('${diretorioTemporario.path}/$nomeArquivo');

    await arquivoTemporario.writeAsBytes(bytes);

    final caminhoSalvo = await FlutterFileDialog.saveFile(
      params: SaveFileDialogParams(
        sourceFilePath: arquivoTemporario.path,
        fileName: nomeArquivo,
      ),
    );

    return caminhoSalvo;
  }
}
