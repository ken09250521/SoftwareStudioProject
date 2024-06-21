import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_setting_page.dart';
import 'start_page.dart';
import 'package:get/get.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => ThemeModel(),
    child: Consumer<ThemeModel>(
      builder: (context, themeModel, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeModel.currentTheme.copyWith(
            textTheme: themeModel.currentTheme.textTheme.apply(fontFamily: 'openSans',
            ),
          ),

          home: const StartPage(),
        );
      }
    ),
  )
);

//ignore: must_be_immutable