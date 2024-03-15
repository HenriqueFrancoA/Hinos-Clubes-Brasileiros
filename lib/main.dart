import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hinos_clubes_brasileiros/screens/hinos/times_screen.dart';
import 'package:hinos_clubes_brasileiros/themes/themes.dart';
import 'package:sizer/sizer.dart';

void main() {
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
        home: const TimesScreen(),
        getPages: [
          GetPage(
            name: '/login',
            page: () => const TimesScreen(),
          ),
        ],
      );
    });
  }
}
