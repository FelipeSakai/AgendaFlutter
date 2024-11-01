
import 'package:agenda/models/DatabaseHelper.dart';
import 'package:agenda/models/UsuarioModel.dart';
import 'package:flutter/material.dart';

class TelaDeCadastro extends StatefulWidget {
  @override
  _TelaDeCadastroState createState() => _TelaDeCadastroState();
}

class _TelaDeCadastroState extends State<TelaDeCadastro> {
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      final usuario = _usuarioController.text;
      final senha = _senhaController.text;

      try {
        await DatabaseService.instance.novoUsuario( contato:UsuarioModel(usuario: usuario, senha: senha));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Usuário cadastrado com sucesso')));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao cadastrar usuário')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
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
                validator: (value) => value!.isEmpty ? 'Usuário obrigatório' : null,
              ),
              TextFormField(
                controller: _senhaController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Senha obrigatória' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _cadastrar, child: Text('Cadastrar')),
            ],
          ),
        ),
      ),
    );
  }
}
