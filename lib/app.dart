import 'package:flutter/material.dart';
import 'package:mobile_application6/ui/screens/splash_screen.dart';

class NestBidzApp extends StatelessWidget {
  const NestBidzApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NestBidzApp',
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.lightBlueAccent,
            contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide.none),
          ),
          textTheme:  const TextTheme(
            titleLarge: TextStyle(
                fontSize: 32,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontStyle:FontStyle.italic,
                letterSpacing: 0.6
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 10),
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
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
