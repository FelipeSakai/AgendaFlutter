import 'package:agenda/telas/TelaDeLogin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'telas/TelaDeListagem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> _verificarToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }

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
      home: TelaDeLogin(),
    );
  }
}
