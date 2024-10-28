import 'package:agenda/models/Contato.dart';
import 'package:agenda/models/GerenciadorDeContatos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';


class TelaDeEdicao extends StatefulWidget {
  final Contato contato;
  final GerenciadorDeContatos gerenciadorDeContatos;
  final int indiceDoContato;
  final VoidCallback aoAtualizarContato;

  TelaDeEdicao({
    required this.contato,
    required this.gerenciadorDeContatos,
    required this.indiceDoContato,
    required this.aoAtualizarContato,
  });

  @override
  _TelaDeEdicaoState createState() => _TelaDeEdicaoState();
}

class _TelaDeEdicaoState extends State<TelaDeEdicao> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final MaskedTextController _telefoneController = MaskedTextController(mask: '(00) 00000-0000');
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.contato.nome;
    _telefoneController.text = widget.contato.telefone;
    _emailController.text = widget.contato.email;
  }

  void _salvarContato() {
    if (_formKey.currentState!.validate()) {
      widget.gerenciadorDeContatos.atualizarContato(
        Contato(
          id: widget.indiceDoContato,
          nome: _nomeController.text,
          telefone: _telefoneController.text,
          email: _emailController.text,
        ),
      );
      widget.aoAtualizarContato();
      Navigator.pop(context);
    }
  }

  void _deletarContato() {
    widget.gerenciadorDeContatos.deletarContato(widget.indiceDoContato);
    widget.aoAtualizarContato();
    Navigator.pop(context);
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
        title: Text('Editar Contato'),
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
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _deletarContato,
                child: Text('Deletar Contato',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
