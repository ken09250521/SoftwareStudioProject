//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'themes.dart';
import 'package:provider/provider.dart';

var curTheme = keroroLightTheme;
bool switched = false;
int lastPage = 0;

class ThemeModel extends ChangeNotifier {
  ThemeData _currentTheme = keroroLightTheme;

  ThemeData get currentTheme => _currentTheme;

  void changeTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}

final keroroLightTheme = ThemeData.from(colorScheme: keroroLightColorScheme);
final keroroDarkTheme = ThemeData.from(colorScheme: keroroDarkColorScheme);
final giroroLightTheme = ThemeData.from(colorScheme: giroroLightColorScheme);
final giroroDarkTheme = ThemeData.from(colorScheme: giroroDarkColorScheme);
final dororoLightTheme = ThemeData.from(colorScheme: dororoLightColorScheme);
final dororoDarkTheme = ThemeData.from(colorScheme: dororoDarkColorScheme);
final kururuLightTheme = ThemeData.from(colorScheme: kururuLightColorScheme);
final kururuDarkTheme = ThemeData.from(colorScheme: kururuDarkColorScheme);
final tamamaLightTheme = ThemeData.from(colorScheme: tamamaLightColorScheme);
final tamamaDarkTheme = ThemeData.from(colorScheme: tamamaDarkColorScheme);

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
                  context.read<ThemeModel>().changeTheme(keroroLightTheme);
                }
                if (theme == 0 && switched == true) {
                  context.read<ThemeModel>().changeTheme(keroroDarkTheme);
                }
                if (theme == 1 && switched == false) {
                  context.read<ThemeModel>().changeTheme(giroroLightTheme);
                }
                if (theme == 1 && switched == true) {
                  context.read<ThemeModel>().changeTheme(giroroDarkTheme);
                }
                if (theme == 2 && switched == false){
                  context.read<ThemeModel>().changeTheme(dororoLightTheme);
                }
                if (theme == 2 && switched == true){
                  context.read<ThemeModel>().changeTheme(dororoDarkTheme);
                }
                if (theme == 3 && switched == false){
                  context.read<ThemeModel>().changeTheme(kururuLightTheme);
                }
                if (theme == 3 && switched == true){
                  context.read<ThemeModel>().changeTheme(kururuDarkTheme);
                }
                if (theme == 4 && switched == false){
                  context.read<ThemeModel>().changeTheme(tamamaLightTheme);
                }
                if (theme == 4 && switched == true){
                  context.read<ThemeModel>().changeTheme(tamamaDarkTheme);
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
            context.read<ThemeModel>().changeTheme(keroroLightTheme);
          }
          if (theme == 0 && switched == true) {
            context.read<ThemeModel>().changeTheme(keroroDarkTheme);
          }
          if (theme == 1 && switched == false) {
            context.read<ThemeModel>().changeTheme(giroroLightTheme);
          }
          if (theme == 1 && switched == true) {
            context.read<ThemeModel>().changeTheme(giroroDarkTheme);
          }
          if (theme == 2 && switched == false){
            context.read<ThemeModel>().changeTheme(dororoLightTheme);
          }
          if (theme == 2 && switched == true){
            context.read<ThemeModel>().changeTheme(dororoDarkTheme);
          }
          if (theme == 3 && switched == false){
            context.read<ThemeModel>().changeTheme(kururuLightTheme);
          }
          if (theme == 3 && switched == true){
            context.read<ThemeModel>().changeTheme(kururuDarkTheme);
          }
          if (theme == 4 && switched == false){
            context.read<ThemeModel>().changeTheme(tamamaLightTheme);
          }
          if (theme == 4 && switched == true){
            context.read<ThemeModel>().changeTheme(tamamaDarkTheme);
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
                  'Keroro',
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
                  'Giroro',
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
                  'Dororo',
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
                  'Kururu',
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
                  'Tamama',
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
