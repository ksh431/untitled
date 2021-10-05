import 'package:flutter/material.dart';
import 'package:untitled/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.red,
            brightness: Brightness.light
        ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          primaryColor: Colors.yellow,
          brightness: Brightness.dark
      ),
      home: HomePage()
    );
  }
}
