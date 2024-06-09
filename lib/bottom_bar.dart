import 'package:flutter/material.dart';
import 'main.dart';
import 'theme_setting_page.dart';
import 'task_page.dart';
import 'add_task.dart';

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
      if (_selectedIdx == 0 ) {
      Navigator.push(context, PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const TaskPage(),
        transitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(-1.0, 0.0);
          var end = Offset.zero;
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
           );
        },
      ));
    }
    if (_selectedIdx == 1) {
      Navigator.push(context, PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const ThemePage(),
        transitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(1.0, 0.0);
          var end = const Offset(0.0, 0.0);
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
           );
        },
      ));
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.primary,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: IconButton(
              icon: Icon(
                Icons.task_alt,
                color: Theme.of(context).colorScheme.onPrimary,
                ),
              onPressed: () => _onItemTapped(0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: IconButton(
              icon: Icon(
                Icons.color_lens_outlined,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () => _onItemTapped(1),
            ),
          ),
        ],
      ),
    );
  }
}