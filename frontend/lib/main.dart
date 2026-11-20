import 'package:flutter/material.dart';
import 'package:frontend/pages/welcome/welcome_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:frontend/viewmodels/compartilhamento_processo_viewmodel.dart';
import 'package:frontend/viewmodels/exportacao_viewmodel.dart';
import 'package:frontend/viewmodels/usuario_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme/app_theme.dart';
import 'theme/theme_preference.dart';
import 'viewmodels/processo_viewmodel.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/favorito_viewmodel.dart';
import 'viewmodels/acesso_viewmodel.dart';
import 'viewmodels/ativo_viewmodel.dart';
import 'viewmodels/documento_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferencias = await SharedPreferences.getInstance();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PreferenciaTema(preferencias)),
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
          ChangeNotifierProvider(create: (_) => DocumentoViewModel()),
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
      theme: temaArgon(Brightness.light),
      darkTheme: temaArgon(Brightness.dark),
      themeMode: context.watch<PreferenciaTema>().modo,
      home: const WelcomePage(),
    );
  }
}
