import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(
      {super.key,
      required this.currentPageIndex,
      required this.updatePageIndex,
      required this.updateAppBarTitle});

  final int currentPageIndex;
  final ValueChanged<int> updatePageIndex;
  final ValueChanged<String> updateAppBarTitle;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.green.shade600,
      currentIndex: widget.currentPageIndex,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      selectedFontSize: 14,
      selectedIconTheme: const IconThemeData(size: 24),
      selectedItemColor: Colors.white,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedFontSize: 12,
      unselectedIconTheme: const IconThemeData(size: 20),
      unselectedItemColor: Colors.white.withOpacity(.50),
      items: const [
        BottomNavigationBarItem(
          label: 'IMC',
          icon: Icon(Icons.scale_outlined),
          activeIcon: Icon(Icons.scale),
        ),
        BottomNavigationBarItem(
          label: 'IMGR',
          icon: Icon(Icons.pregnant_woman_outlined),
          activeIcon: Icon(Icons.pregnant_woman),
        ),
      ],
      onTap: (int index) {
        setState(() {
          widget.updatePageIndex(index);
          widget.updateAppBarTitle(index == 0
              ? 'Calcular Índice de Massa Corporal'
              : 'Calcular Índice de Massa Gorda Relativa');
        });
      },
    );
  }
}
