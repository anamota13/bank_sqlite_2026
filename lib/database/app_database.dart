import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transferencia.dart';
import '../models/contato.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bank.db');
  return openDatabase(
    path,
    version: 2,
    onCreate: (db, version) async {
      await db.execute('CREATE TABLE transferencias(id INTEGER PRIMARY KEY AUTOINCREMENT, valor REAL, numero_conta INTEGER)');
      await db.execute('CREATE TABLE contatos(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, numero_conta INTEGER)');
    },
  );
}

Future<int> salvarTransferencia(Transferencia transferencia) async {
  final Database db = await getDatabase();
  return db.insert('transferencias', {'valor': transferencia.valor, 'numero_conta': transferencia.numeroConta});
}

Future<List<Transferencia>> buscarTransferencias() async {
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> result = await db.query('transferencias');
  return List.generate(result.length, (i) => Transferencia(result[i]['valor'], result[i]['numero_conta']));
}

Future<int> salvarContato(Contato contato) async {
  final Database db = await getDatabase();
  return db.insert('contatos', contato.toMap());
}

Future<List<Contato>> buscarContatos() async {
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> resultado = await db.query('contatos');
  return List.generate(resultado.length, (i) => Contato(
    id: resultado[i]['id'],
    nome: resultado[i]['nome'],
    numeroConta: resultado[i]['numero_conta'],
  ));
}