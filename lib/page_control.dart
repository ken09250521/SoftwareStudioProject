import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'calendar_page.dart';
import 'task_page.dart';
import 'profile_page.dart';
import 'gpt_page.dart';
import 'random_page.dart';
import 'models/task.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PageControl extends StatefulWidget {
  const PageControl({super.key});
  @override
  State<PageControl> createState() => _PageControlState();
}

class _PageControlState extends State<PageControl> {
  int _selectedIndex = 2;
  final List<Widget> _pages = <Widget>[
    const TaskPage(),
    GPTPage(),
    const CalendarPage(),
    const RandomPage(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: FlashyTabBar(
          animationCurve: Curves.linear,
          selectedIndex: _selectedIndex,
          iconSize: 30,
          backgroundColor: Theme.of(context).colorScheme.primary,
          showElevation: false,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: const Icon(LineAwesomeIcons.list_alt_solid),
              title: const Text('Task List'),
              activeColor: Theme.of(context).colorScheme.onPrimary,
              inactiveColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            FlashyTabBarItem(
              icon: const Icon(LineAwesomeIcons.comment_solid),
              title: const Text('Ask AI'),
              activeColor: Theme.of(context).colorScheme.onPrimary,
              inactiveColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            FlashyTabBarItem(
              icon: const Icon(LineAwesomeIcons.calendar_solid),
              title: const Text('Schedule'),
              activeColor: Theme.of(context).colorScheme.onPrimary,
              inactiveColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            FlashyTabBarItem(
              icon: const Icon(LineAwesomeIcons.random_solid),
              title: const Text('Random Task'),
              activeColor: Theme.of(context).colorScheme.onPrimary,
              inactiveColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            FlashyTabBarItem(
              icon: const Icon(LineAwesomeIcons.user_circle),
              title: const Text('Profile'),
              activeColor: Theme.of(context).colorScheme.onPrimary,
              inactiveColor: Theme.of(context).colorScheme.inversePrimary,
            ),
          ],
      
        )
      ),
    );
  }
}

class TaskController extends GetxController {
  var tasks = <Task>[].obs;

  void addTask(String title, String description, DateTime date, UrgencyLevel urgency) {
    final task = Task(title: title, description: description, date: date, urgency: urgency);
    tasks.add(task);
  }
}