import 'package:flutter/material.dart';
import 'package:mobile_application6/ui/screens/splash_screen.dart';



class RentsellifyApp extends StatelessWidget {
  const RentsellifyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RentsellifyApp',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
                fontSize: 32,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.6
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10),
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)
                ),
              )
          )
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
