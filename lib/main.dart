import 'package:flutter/material.dart';
import 'package:wallpaper_f/wallpapers.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Wallpapers",
      theme: ThemeData(brightness: Brightness.dark),
      home: wallpapers(),
    );
  }
}