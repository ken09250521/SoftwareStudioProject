import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bottom_bar.dart';
import 'themes.dart';
import 'package:provider/provider.dart';

var curTheme = blueLightTheme;
bool switched = false;
int lastPage = 0;

class ThemeModel extends ChangeNotifier {
  ThemeData _currentTheme = blueLightTheme;

  ThemeData get currentTheme => _currentTheme;

  void changeTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}

final blueLightTheme = ThemeData.from(colorScheme: blueLightColorScheme);
final blueDarkTheme = ThemeData.from(colorScheme: blueDarkColorScheme);
final waiLightTheme = ThemeData.from(colorScheme: waiLightColorScheme);
final waiDarkTheme = ThemeData.from(colorScheme: waiDarkColorScheme);
final mandyLightTheme = ThemeData.from(colorScheme: mandyLightColorScheme);
final mandyDarkTheme = ThemeData.from(colorScheme: mandyDarkColorScheme);

class ThemePage extends StatefulWidget{
  const ThemePage({super.key});
  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {

  PageController _pageViewController = PageController();
  var theme = 0;
  

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: lastPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Switch(
            value: switched,
            activeColor: Colors.black,
            onChanged: (bool value) {
              setState(() {
                switched = value;
                if (theme == 0 && switched == false) {
                  context.read<ThemeModel>().changeTheme(blueLightTheme);
                }
                if (theme == 0 && switched == true) {
                  context.read<ThemeModel>().changeTheme(blueDarkTheme);
                }
                if (theme == 1 && switched == false) {
                  context.read<ThemeModel>().changeTheme(waiLightTheme);
                }
                if (theme == 1 && switched == true) {
                  context.read<ThemeModel>().changeTheme(waiDarkTheme);
                }
                if (theme == 2 && switched == false){
                  context.read<ThemeModel>().changeTheme(mandyLightTheme);
                }
                if (theme == 2 && switched == true){
                  context.read<ThemeModel>().changeTheme(mandyDarkTheme);
                }
              });
            },
          ),
      ),
      body: PageView(
        controller: _pageViewController,
        onPageChanged: (theme) {
          lastPage = theme;
          if (theme == 0 && switched == false) {
            context.read<ThemeModel>().changeTheme(blueLightTheme);
          }
          if (theme == 0 && switched == true) {
            context.read<ThemeModel>().changeTheme(blueDarkTheme);
          }
          if (theme == 1 && switched == false) {
            context.read<ThemeModel>().changeTheme(waiLightTheme);
          }
          if (theme == 1 && switched == true) {
            context.read<ThemeModel>().changeTheme(waiDarkTheme);
          }
          if (theme == 2 && switched == false){
            context.read<ThemeModel>().changeTheme(mandyLightTheme);
          }
          if (theme == 2 && switched == true){
            context.read<ThemeModel>().changeTheme(mandyDarkTheme);
          }
        },
        children:  <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: (){
                    if (_pageViewController.hasClients){
                      _pageViewController.previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios)
                ),
                Text(
                  'Blue Chill',
                  style: GoogleFonts.openSans(),
                ),
                IconButton(
                  onPressed: (){
                    if (_pageViewController.hasClients){
                      _pageViewController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: const Icon(Icons.arrow_forward_ios)
                ),
              ],
            )
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: (){
                    if (_pageViewController.hasClients){
                      _pageViewController.previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios)
                ),
                Text(
                  'Waikawa Gray',
                  style: GoogleFonts.openSans(),
                ),
                IconButton(
                  onPressed: (){
                    if (_pageViewController.hasClients){
                      _pageViewController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: const Icon(Icons.arrow_forward_ios)
                ),
              ],
            )
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: (){
                    if (_pageViewController.hasClients){
                      _pageViewController.previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios)
                ),
                Text(
                  'Mandy',
                  style: GoogleFonts.openSans(),
                ),
                IconButton(
                  onPressed: (){
                    if (_pageViewController.hasClients){
                      _pageViewController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: const Icon(Icons.arrow_forward_ios)
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
