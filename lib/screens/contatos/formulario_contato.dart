import 'package:flutter/material.dart';
import '../../components/editor.dart';
import '../../models/contato.dart';
import '../../database/app_database.dart';

class FormularioContato extends StatefulWidget {
  const FormularioContato({super.key});

  @override
  State<FormularioContato> createState() => _FormularioContatoState();
}

class _FormularioContatoState extends State<FormularioContato> {
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorConta = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Contato')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controlador: _controladorNome,
              rotulo: 'Nome',
              dica: 'Ex: Maria Oliveira',
              icone: Icons.person,
              tipoTeclado: TextInputType.text,
            ),
            Editor(
              controlador: _controladorConta,
              rotulo: 'Número da conta',
              dica: '0000',
              icone: Icons.numbers,
              tipoTeclado: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: const Text('Criar'),
                  onPressed: () {
                    final String nome = _controladorNome.text;
                    final int? conta = int.tryParse(_controladorConta.text);
                    if (nome.isNotEmpty && conta != null) {
                      final novoContato = Contato(nome: nome, numeroConta: conta);
                      salvarContato(novoContato).then((id) => Navigator.pop(context));
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}