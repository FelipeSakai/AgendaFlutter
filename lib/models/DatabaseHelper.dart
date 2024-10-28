import 'dart:async';
import 'package:agenda/models/Contato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._constructor();

  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String nomeDaTabela = "tb_contatos";
  final String nomeDaTabelaUsuario = "tb_usuario";

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await getDatabase();
      return _db!;
    }
  }

  Future<Database> getDatabase() async {
    final databaseDir = await getDatabasesPath();

    final databasePath = join(databaseDir, "agenda_db.db");
    final database = await openDatabase(
      version: 1,
      databasePath,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $nomeDaTabelaUsuario(
            id INTEGER PRIMARY KEY,
            usuario TEXT NOT NULL,
            senha TEXT NOT NULL
          )
        ''');
        db.execute('''
          CREATE TABLE $nomeDaTabela(
            id INTEGER PRIMARY KEY,
            nome TEXT NOT NULL,
            email TEXT NOT NULL,
            numero TEXT NOT NULL
          )
        ''');
      },
      onOpen: (db) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS $nomeDaTabelaUsuario(
            id INTEGER PRIMARY KEY,
            usuario TEXT NOT NULL,
            senha TEXT NOT NULL
          )
        ''');
      },
    );
    return database;
  }



  void novoContato({required Contato contato}) async {
    final db = await database;

    db.insert(
      nomeDaTabela,
      {
        "nome": contato.nome,
        "email": contato.email,
        "numero": contato.telefone,
      },
    );
  }

  Future<List<Contato>> recuperaContatos() async {
    final db = await database;

    final contatos = await db.query(nomeDaTabela);

    return contatos
        .map(
          (e) => Contato(
            id: e['id'] as int,
            nome: e['nome'].toString(),
            telefone: e['numero'].toString(),
            email: e['email'].toString(),
          ),
        )
        .toList();
  }

  Future<void> updateContato(Contato contato) async {
    final db = await database;

    await db.update(
        nomeDaTabela,
        {
          "nome": contato.nome,
          "email": contato.email,
          "numero": contato.telefone,
        },
        where: 'id = ?',
        whereArgs: [contato.id!]);
  }

  Future<void> deleteContato(int id) async {
    final db = await database;

    await db.delete(nomeDaTabela, where: 'id = ?', whereArgs: [id]);
  }
}