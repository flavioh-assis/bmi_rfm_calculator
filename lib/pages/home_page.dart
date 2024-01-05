import 'package:flutter/material.dart';
import 'dart:math';

import '/utils.dart';
import '/pages/bmi_page.dart';
import '/widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  late PageController _pageController;

  double _height = 0;
  double _weight = 0;
  double _bmiResult = 0;

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

  void _setPageIndex(int pageIndex) {
    setState(() {
      _currentPageIndex = pageIndex;
      _pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
      );
    });
  }

  void _setHeight(String height) {
    setState(() {
      _height = textToDouble(height);
    });
  }

  void _setWeight(String weight) {
    setState(() {
      _weight = textToDouble(weight);
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _setPageIndex,
        children: [
          BmiPage(
            bmiResult: _bmiResult,
            calculateBMI: _calculateBMI,
            cleanFields: _cleanFields,
            updateHeight: _setHeight,
            updateWeight: _setWeight,
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
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentPageIndex: _currentPageIndex,
        updatePageIndex: _setPageIndex,
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
