import 'package:agenda/models/Contato.dart';
import 'package:agenda/models/DatabaseHelper.dart';

class GerenciadorDeContatos {

  Future<void> adicionarContato(Contato contato) async {
   final db=DatabaseService.instance;
   db.novoContato(contato: contato);
  }

  Future<List<Contato>> obterContatos() async {
    final db=DatabaseService.instance;
    return await db.recuperaContatos();
  }

  Future<void> atualizarContato(Contato contato) async {
    final db=DatabaseService.instance;
    await db.updateContato(contato);
  }

  Future<void> deletarContato(int id) async {
    final db=DatabaseService.instance;
    await db.deleteContato(id);
  }
}
