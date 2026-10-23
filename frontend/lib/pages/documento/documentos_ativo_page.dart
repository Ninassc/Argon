import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../../viewmodels/documento_viewmodel.dart';

class DocumentosAtivoPage extends StatefulWidget {
  final int idAtivo;
  final bool podeEditar;

  const DocumentosAtivoPage({
    super.key,
    required this.idAtivo,
    required this.podeEditar,
  });

  @override
  State<DocumentosAtivoPage> createState() => _DocumentosAtivoPageState();
}

class _DocumentosAtivoPageState extends State<DocumentosAtivoPage> {
  String? erro;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      carregarDocumentos();
    });
  }

  Future<void> carregarDocumentos() async {
    try {
      setState(() {
        erro = null;
      });

      await context.read<DocumentoViewModel>().listarPorAtivo(widget.idAtivo);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        erro = e.toString().replaceFirst("Exception: ", "");
      });
    }
  }

  Future<void> selecionarDocumento() async {
    if (!widget.podeEditar) return;

    final documentoViewModel = context.read<DocumentoViewModel>();

    try {
      final resultado = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'docx'],
      );

      if (resultado == null || resultado.isEmpty) return;

      final arquivo = resultado.first;

      final tamanho = await arquivo.length();

      if (tamanho == null) {
        throw Exception("Não foi possível verificar o tamanho do arquivo.");
      }

      if (tamanho > 10 * 1024 * 1024) {
        throw Exception("O arquivo deve ter no máximo 10 MB.");
      }

      await documentoViewModel.cadastrar(widget.idAtivo, arquivo);

      if (!mounted) return;

      await carregarDocumentos();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Documento anexado com sucesso!")),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  Future<void> baixarDocumento(int idDocumento, String nomeOriginal) async {
    final documentoViewModel = context.read<DocumentoViewModel>();

    try {
      final bytes = await documentoViewModel.baixar(idDocumento);

      if (!mounted) return;

      final caminho = await FilePicker.saveFile(
        dialogTitle: "Salvar documento",
        fileName: nomeOriginal,
        bytes: bytes,
      );

      if (!mounted || caminho == null) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Documento salvo com sucesso!")),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final documentoViewModel = context.watch<DocumentoViewModel>();

    final documentos = documentoViewModel.documentos;

    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset("assets/images/ArgON.png", height: 42),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFE0E0E0), width: 2),
              ),
              child: Icon(
                Icons.chevron_left,
                size: 30,
                color: Color(0xFF848484),
              ),
            ),
          ),
        ),
      ),

      floatingActionButton: widget.podeEditar
          ? FloatingActionButton.extended(
              onPressed: documentoViewModel.carregando
                  ? null
                  : selecionarDocumento,
              backgroundColor: const Color(0xFF5A81FA),
              foregroundColor: Colors.white,
              icon: const Icon(Icons.upload_file_outlined),
              label: const Text("Anexar documento"),
            )
          : null,

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: documentoViewModel.carregando
            ? const Center(child: CircularProgressIndicator())
            : erro != null
            ? Center(child: Text(erro!))
            : documentos.isEmpty
            ? const Center(child: Text("Nenhum documento anexado."))
            : ListView.separated(
                itemCount: documentos.length,
                separatorBuilder: (_, _) => const Divider(),
                itemBuilder: (context, index) {
                  final documento = documentos[index];

                  return ListTile(
                    leading: const Icon(
                      Icons.insert_drive_file_outlined,
                      color: Color(0xFF5A81FA),
                    ),
                    title: Text(documento.nomeOriginal),
                    subtitle: Text(
                      "${(documento.tamanho / 1024).toStringAsFixed(1)} KB",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.download_outlined),
                      onPressed: documentoViewModel.carregando
                          ? null
                          : () => baixarDocumento(
                              documento.idDocumento,
                              documento.nomeOriginal,
                            ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
