import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';
import 'package:frontend/theme/theme_preference.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Alterna e restaura a preferência de tema', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final preferencias = await SharedPreferences.getInstance();
    final plataforma = tester.binding.platformDispatcher;
    plataforma.platformBrightnessTestValue = Brightness.light;
    addTearDown(plataforma.clearPlatformBrightnessTestValue);

    Widget criarApp() => ChangeNotifierProvider(
      create: (_) => PreferenciaTema(preferencias),
      child: const MyApp(),
    );

    Brightness brilho() =>
        Theme.of(tester.element(find.byType(Scaffold))).brightness;

    Future<void> selecionar(String opcao) async {
      await tester.tap(find.byTooltip('Tema do app'));
      await tester.pumpAndSettle();
      await tester.tap(
        find.widgetWithText(CheckedPopupMenuItem<ThemeMode>, opcao),
      );
      await tester.pumpAndSettle();
    }

    await tester.pumpWidget(criarApp());
    await tester.pumpAndSettle();
    expect(brilho(), Brightness.light);

    await selecionar('Escuro');
    expect(brilho(), Brightness.dark);
    expect(preferencias.getString('theme_mode'), 'dark');

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(criarApp());
    await tester.pumpAndSettle();
    expect(brilho(), Brightness.dark);

    await selecionar('Claro');
    plataforma.platformBrightnessTestValue = Brightness.dark;
    await tester.pumpAndSettle();
    expect(brilho(), Brightness.light);

    await selecionar('Sistema');
    expect(brilho(), Brightness.dark);
  });
}
