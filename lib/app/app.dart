import 'package:flutter/material.dart';
import 'package:task_list/app/view/home/inherited_widgets.dart';
import 'package:task_list/app/view/home/state_page.dart';
import 'package:task_list/app/view/splash/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF40B7AD);
    const textColor = Color(0xFF4A4A4A);
    const backgroundColor = Color(0xFFF5F5F5);
    return SpecialColor(
      color: Colors.black26,
      child: MaterialApp(
        title: 'Task List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: primary,
            primary: primary,
          ),
          scaffoldBackgroundColor: backgroundColor,
          textTheme: Theme.of(context).textTheme.apply(
            fontFamily: "Poppins",
            bodyColor: textColor,
            displayColor: textColor,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: primary
          ),
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.transparent
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 54),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700
              )
            )
          )
        ),

        home: SplashPage(),
      ),
    );
  }
}