import 'package:flutter/material.dart';
import 'package:gardmenu_training/pages/page_home.dart';
import './styles/style_elevated_button.dart';

void main() {
  runApp(const GardMenu());
}

class GardMenu extends StatelessWidget {
  const GardMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gard Menu',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
        elevatedButtonTheme:
            ElevatedButtonThemeData(style: getCustomElevatedButtonStyle()),
      ),
      home: const HomePage(),
    );
  }
}
