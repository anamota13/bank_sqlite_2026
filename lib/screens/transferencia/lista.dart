import 'package:flutter/material.dart';
import 'formulario.dart';
import '../../models/transferencia.dart';
import '../../database/app_database.dart'; // Importante para as funções do banco
import 'package:intl/intl.dart';

class ListaTransferencias extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListaTranferenciaState();
  }
}

class ListaTranferenciaState extends State<ListaTransferencias> {
  static const _tituloAppBar = 'Transferências';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
      ),
      // MUDANÇA AQUI: Usamos FutureBuilder para ler o SQLite
      body: FutureBuilder<List<Transferencia>>(
        future: buscarTransferencias(), // Função que criamos no app_database.dart
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transferencia>? transferencias = snapshot.data;
                if (transferencias != null && transferencias.isNotEmpty) {
                  return ListView.builder(
                    itemCount: transferencias.length,
                    itemBuilder: (context, indice) {
                      final transferencia = transferencias[indice];
                      return ItemTransferencia(transferencia);
                    },
                  );
                }
              }
              return Center(
                child: Text('Nenhuma transferência encontrada'),
              );
            
            default:
              return Center(child: Text('Erro desconhecido'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Usamos Navigator com await para esperar o retorno e atualizar a tela
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormularioTransferencia(),
            ),
          ).then((value) => setState(() {})); // Atualiza a tela ao voltar
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    final formatador = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on, color: Colors.green),
        title: Text(formatador.format(_transferencia.valor)),
        subtitle: Text('Conta: ${_transferencia.numeroConta}'),
      ),
    );
  }
}