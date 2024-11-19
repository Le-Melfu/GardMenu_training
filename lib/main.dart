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
      home: const HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: TextTheme(bodyMedium: defaultFont),
        elevatedButtonTheme:
            ElevatedButtonThemeData(style: getCustomElevatedButtonStyle()),
      ),
    );
  }
}

const defaultFont = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 16.0,
  color: Colors.black,
);
