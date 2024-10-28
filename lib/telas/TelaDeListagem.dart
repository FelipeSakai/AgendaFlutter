import 'package:agenda/models/Contato.dart';
import 'package:agenda/models/GerenciadorDeContatos.dart';
import 'package:agenda/telas/TelaDeCriacao.dart';
import 'package:agenda/telas/TelaDeEdicao.dart';
import 'package:flutter/material.dart';

class TelaDeListagem extends StatefulWidget {
  @override
  _TelaDeListagemState createState() => _TelaDeListagemState();
}

class _TelaDeListagemState extends State<TelaDeListagem> {
  final GerenciadorDeContatos _gerenciadorDeContatos = GerenciadorDeContatos();
  List<Contato> _contatos = [];

  @override
  void initState() {
    super.initState();
    _carregarContatos();
  }

  Future<void> _carregarContatos() async {
    final contatos = await _gerenciadorDeContatos.obterContatos();
    setState(() {
      _contatos = contatos;
    });
  }

  void _atualizarTela() {
    _carregarContatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
      ),
      body: Container(
        color: Colors.grey[800],
        child: ListView.builder(
          itemCount: _contatos.length + 1,
          itemBuilder: (context, indice) {
            if (indice == 0) {
              return ListTile(
                title: Text(
                  'Criar novo contato',
                  style: TextStyle(color: Colors.blue),
                ),
                leading: Icon(Icons.add, color: Colors.blue),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaDeCriacao(
                        gerenciadorDeContatos: _gerenciadorDeContatos,
                        aoAdicionarContato: _atualizarTela,
                      ),
                    ),
                  );
                },
              );
            } else {
              final contato = _contatos[indice - 1];
              return ListTile(
                title: Text(contato.nome, style: TextStyle(color: Colors.white)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Telefone: ${contato.telefone}', style: TextStyle(color: Colors.grey[400])),
                    Text('Email: ${contato.email}', style: TextStyle(color: Colors.grey[400])),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaDeEdicao(
                          contato: contato,
                          gerenciadorDeContatos: _gerenciadorDeContatos,
                          indiceDoContato: contato.id!,
                          aoAtualizarContato: _atualizarTela,
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}