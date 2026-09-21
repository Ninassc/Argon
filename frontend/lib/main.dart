import 'package:flutter/material.dart';
import 'package:frontend/pages/welcome/welcome_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:frontend/viewmodels/compartilhamento_processo_viewmodel.dart';
import 'package:frontend/viewmodels/exportacao_viewmodel.dart';
import 'package:frontend/viewmodels/usuario_viewmodel.dart';
import 'package:provider/provider.dart';

import 'viewmodels/processo_viewmodel.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/favorito_viewmodel.dart';
import 'viewmodels/acesso_viewmodel.dart';
import 'viewmodels/ativo_viewmodel.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProcessoViewModel()),
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => FavoritoViewModel()),
          ChangeNotifierProvider(create: (_) => AcessoViewModel()),
          ChangeNotifierProvider(create: (_) => AtivoViewModel()),
          ChangeNotifierProvider(create: (_) => UsuarioViewModel()),
          ChangeNotifierProvider(
            create: (_) => CompartilhamentoProcessoViewmodel(),
          ),
          ChangeNotifierProvider(create: (_) => ExportacaoViewModel()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Argon',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5A81FA)),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color.fromARGB(255, 168, 173, 187),
          contentTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
      ),
      home: const WelcomePage(),
    );
  }
}

//#5A81FA
