import 'package:flutter/material.dart';
import 'package:store_app/consts/themes.dart';

import 'consts/global_colors.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store App ',
      theme: Themes.getThemeData,
      home: const HomeScreen(),
    );
  }
}
