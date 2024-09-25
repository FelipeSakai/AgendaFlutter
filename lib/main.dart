import 'package:flutter/material.dart';
import 'telas/TelaDeListagem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Agenda',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.blue,
          surface: Colors.grey[850]!,
          onPrimary: Colors.white,
          onSurface: Colors.white,
        ),
      ),
      home: TelaDeListagem(),
    );
  }
}
