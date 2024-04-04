import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hinos_clubes_brasileiros/screens/hinos/times_screen.dart';
import 'package:hinos_clubes_brasileiros/screens/loading/loading_screen.dart';
import 'package:hinos_clubes_brasileiros/themes/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

bool arquivos = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  arquivos = prefs.getBool("arquivos") ?? false;

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Hino Clubes Brasileiros',
        themeMode: ThemeMode.light,
        theme: lightTheme,
        home: arquivos ? const TimesScreen() : const LoadingScreen(),
        getPages: [
          GetPage(
            name: '/home',
            page: () => const TimesScreen(),
          ),
          GetPage(
            name: '/loading',
            page: () => const LoadingScreen(),
          ),
        ],
      );
    });
  }
}
