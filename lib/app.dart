import 'package:flutter/material.dart';
import 'dart:math';

import 'pages/bmi_page.dart';
import 'widgets/bottom_nav_bar.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentPageIndex = 0;
  String _pageTitle = 'Calcular Índice de Massa Corporal';

  double _height = 0;
  double _weight = 0;
  double _bmiResult = 0;

  void _updatePageIndex(int pageIndex) {
    setState(() {
      _currentPageIndex = pageIndex;
    });
  }

  void _updateAppBarTitle(String title) {
    setState(() {
      _pageTitle = title;
    });
  }

  void _updateHeight(String height) {
    setState(() {
      _height = textToDouble(height);
    });
  }

  void _updateWeight(String weight) {
    setState(() {
      _weight = textToDouble(weight);
    });
  }

  void _calculateBMI() {
    setState(() {
      _bmiResult = _weight / pow(_height, 2);
    });
  }

  void _cleanFields() {
    setState(() {
      _height = 0;
      _weight = 0;
      _bmiResult = 0;
    });
  }

  double textToDouble(String text) {
    if (text.isEmpty) {
      return 0.0;
    }

    return double.parse(text.replaceFirst(',', '.'));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      BmiPage(
        bmiResult: _bmiResult,
        calculateBMI: _calculateBMI,
        cleanFields: _cleanFields,
        updateHeight: _updateHeight,
        updateWeight: _updateWeight,
      ),
      Container(
        color: Colors.green.shade400,
        child: const Center(
          child: Text(
            'IMGR',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de IMC e IMGR',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(
            child: Text(
              _pageTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
        body: pages[_currentPageIndex],
        bottomNavigationBar: BottomNavBar(
          currentPageIndex: _currentPageIndex,
          updatePageIndex: _updatePageIndex,
          updateAppBarTitle: _updateAppBarTitle,
        ),
      ),
    );
  }
}
