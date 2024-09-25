import 'Contato.dart';

class GerenciadorDeContatos {
  final List<Contato> _contatos = [];

  List<Contato> get contatos => List.unmodifiable(_contatos);

  void adicionarContato(Contato contato) {
    _contatos.add(contato);
  }

  void atualizarContato(int indice, Contato contatoAtualizado) {
    _contatos[indice] = contatoAtualizado;
  }

  void deletarContato(int indice) {
    _contatos.removeAt(indice);
  }
}
