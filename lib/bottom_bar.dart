import 'package:flutter/material.dart';
import 'main.dart';
import 'theme_setting_page.dart';

class BottomBar extends StatefulWidget {
  BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIdx = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIdx = index;
      if (_selectedIdx == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ThemePage()));
      }
      if (_selectedIdx == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EventCalendar()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
      ],
      selectedItemColor: Colors.purple,
      currentIndex: _selectedIdx,
      onTap: _onItemTapped,
    );
  }
}