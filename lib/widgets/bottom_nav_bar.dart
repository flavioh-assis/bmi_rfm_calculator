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
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Colors.green.shade600,
      destinations: const [
        NavigationDestination(
          label: 'IMC',
          icon: Icon(Icons.scale_outlined),
          selectedIcon: Icon(Icons.scale),
        ),
        NavigationDestination(
          label: 'IMGR',
          icon: Icon(Icons.pregnant_woman_outlined),
          selectedIcon: Icon(Icons.pregnant_woman),
        ),
      ],
      height: 60,
      indicatorColor: Colors.white,
      onDestinationSelected: (int index) {
        setState(() {
          widget.updatePageIndex(index);
        });
      },
      overlayColor: const MaterialStatePropertyAll<Color>(
        Color.fromARGB(255, 226, 226, 226),
      ),
      selectedIndex: widget.currentPageIndex,
    );
  }
}
