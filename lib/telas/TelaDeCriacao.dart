import 'package:agenda/models/Contato.dart';
import 'package:agenda/models/GerenciadorDeContatos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class TelaDeCriacao extends StatefulWidget {
  final GerenciadorDeContatos gerenciadorDeContatos;
  final VoidCallback aoAdicionarContato;

  TelaDeCriacao({required this.gerenciadorDeContatos, required this.aoAdicionarContato});

  @override
  _TelaDeCriacaoState createState() => _TelaDeCriacaoState();
}

class _TelaDeCriacaoState extends State<TelaDeCriacao> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final MaskedTextController _telefoneController = MaskedTextController(mask: '(00) 00000-0000');
  final TextEditingController _emailController = TextEditingController();

  void _salvarContato() {
    if (_formKey.currentState!.validate()) {
      widget.gerenciadorDeContatos.adicionarContato(
        Contato(
          nome: _nomeController.text,
          telefone: _telefoneController.text,
          email: _emailController.text,
        ),
      );
      widget.aoAdicionarContato();
      Navigator.pop(context);
    }
  }

  String? _validarEmail(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'O email é obrigatório';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(valor)) {
      return 'Por favor, insira um email válido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Contato'),
      ),
      body: Container(
        color: Colors.grey[800],
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome', labelStyle: TextStyle(color: Colors.white)),
                controller: _nomeController,
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'O nome é obrigatório';
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Telefone', labelStyle: TextStyle(color: Colors.white)),
                controller: _telefoneController,
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'O telefone é obrigatório';
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: Colors.white)),
                controller: _emailController,
                validator: _validarEmail,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarContato,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
