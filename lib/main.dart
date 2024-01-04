import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de IMC e IMGR',
      theme: ThemeData(
        primaryColor: Colors.green,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
