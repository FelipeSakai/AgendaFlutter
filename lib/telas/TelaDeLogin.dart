import 'package:agenda/models/DatabaseHelper.dart';
import 'package:agenda/models/UsuarioModel.dart';
import 'package:agenda/telas/TelaDeCadastro.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TelaDeListagem.dart';

class TelaDeLogin extends StatefulWidget {
  @override
  _TelaDeLoginState createState() => _TelaDeLoginState();
}

class _TelaDeLoginState extends State<TelaDeLogin> {
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    verificarLogin();
  }

  Future<void> verificarLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TelaDeListagem(),
        ),
      );
    }
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final usuario = _usuarioController.text;
      final senha = _senhaController.text;

      final autenticado = await DatabaseService.instance.verificarLogin(
          usuarioModel: UsuarioModel(usuario: usuario, senha: senha));
      if (autenticado) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', usuario);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TelaDeListagem()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login ou senha incorretos')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usuarioController,
                decoration: InputDecoration(labelText: 'Usuário'),
                validator: (value) =>
                    value!.isEmpty ? 'Usuário obrigatório' : null,
              ),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Senha obrigatória' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _login, child: Text('Entrar')),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaDeCadastro()));
                },
                child: Text('Cadastrar novo usuário'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
