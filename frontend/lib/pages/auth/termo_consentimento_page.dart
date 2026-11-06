import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class TermoConsentimentoPage extends StatefulWidget {
  const TermoConsentimentoPage({super.key});

  @override
  State<TermoConsentimentoPage> createState() => _TermoConsentimentoPageState();
}

class _TermoConsentimentoPageState extends State<TermoConsentimentoPage> {
  String? caminhoPdf;
  String? erro;

  @override
  void initState() {
    super.initState();
    carregarPdf();
  }

  Future<void> carregarPdf() async {
    try {
      final bytes = await rootBundle.load(
        'assets/docs/termo_consentimento.pdf',
      );

      final diretorio = await getTemporaryDirectory();
      final arquivo = File('${diretorio.path}/termo_consentimento.pdf');

      await arquivo.writeAsBytes(bytes.buffer.asUint8List(), flush: true);

      if (!mounted) return;

      setState(() {
        caminhoPdf = arquivo.path;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        erro = 'Não foi possível carregar o termo: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Termo de Consentimento'),
      ),
      body: erro != null
          ? Center(child: Text(erro!))
          : caminhoPdf == null
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: caminhoPdf!,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              onError: (error) {
                if (!mounted) return;

                setState(() {
                  erro = error.toString();
                });
              },
            ),
    );
  }
}
