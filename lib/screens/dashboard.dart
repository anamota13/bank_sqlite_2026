import 'package:flutter/material.dart';
import 'contatos/lista_contatos.dart';
import 'transferencia/lista.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bytebank')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('images/bytebank_logo.png'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _ItemMenu(
                  "Contatos", 
                  Icons.people, 
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ListaContatos()))
                ),
                _ItemMenu(
                  "Transferências", 
                  Icons.description, 
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListaTransferencias()))
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemMenu extends StatelessWidget {
  final String titulo;
  final IconData icone;
  final Function onTap;
  const _ItemMenu(this.titulo, this.icone, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onTap(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 100, width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icone, color: Colors.white, size: 24.0),
                Text(titulo, style: const TextStyle(color: Colors.white, fontSize: 16.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}