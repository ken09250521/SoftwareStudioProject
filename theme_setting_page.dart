import 'package:flutter/material.dart';
import 'bottom_bar.dart';

class ThemePage extends StatefulWidget{
  const ThemePage({super.key});
  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Settings'),
      ),
    );
  }
}