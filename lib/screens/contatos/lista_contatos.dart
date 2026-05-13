import 'package:flutter/material.dart';
import 'formulario_contato.dart';
import '../../models/contato.dart';
import '../../database/app_database.dart';
import '../transferencia/formulario.dart';

class ListaContatos extends StatefulWidget {
  const ListaContatos({super.key});
  @override
  State<ListaContatos> createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  final List<Contato> _contatos = [];

  void _atualizarLista() async {
    final List<Contato> contatosDoBanco = await buscarContatos();
    setState(() {
      _contatos.clear();
      _contatos.addAll(contatosDoBanco);
    });
  }

  @override
  void initState() {
    super.initState();
    _atualizarLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contatos')),
      body: ListView.builder(
        itemCount: _contatos.length,
        itemBuilder: (context, index) {
          final contato = _contatos[index];
          return Card(
            child: ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormularioTransferencia(numeroConta: contato.numeroConta))),
              leading: const Icon(Icons.person),
              title: Text(contato.nome),
              subtitle: Text('Conta: ${contato.numeroConta}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FormularioContato())).then((value) => _atualizarLista()),
        child: const Icon(Icons.add),
      ),
    );
  }
}