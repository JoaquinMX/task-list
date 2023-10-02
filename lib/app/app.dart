import 'package:flutter/material.dart';
import 'package:task_list/app/view/home.dart';
import 'package:task_list/app/view/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF40B7AD);
    const textColor = Color(0xFF4A4A4A);
    const backgroundColor = Color(0xFFF5F5F5);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: "Poppins",
          bodyColor: textColor,
          displayColor: textColor
        )
      ),
      home: SplashPage(),
    );
  }
}