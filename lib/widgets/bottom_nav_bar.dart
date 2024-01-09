import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.currentPageIndex,
    required this.updatePageIndex,
  });

  final int currentPageIndex;
  final ValueChanged<int> updatePageIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void _onItemTapped(int index) {
    setState(() {
      widget.updatePageIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentPageIndex,
      type: BottomNavigationBarType.fixed,
      onTap: _onItemTapped,
      showSelectedLabels: true,
      selectedFontSize: 14,
      selectedIconTheme: const IconThemeData(size: 24),
      selectedItemColor: Theme.of(context).primaryColor,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      unselectedFontSize: 12,
      unselectedIconTheme: const IconThemeData(size: 20),
      unselectedItemColor: Colors.black.withOpacity(.75),
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
    );
  }
}
