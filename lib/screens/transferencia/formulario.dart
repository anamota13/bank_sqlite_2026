import 'package:flutter/material.dart';
import '../../components/editor.dart';
import '../../models/transferencia.dart';
import '../../database/app_database.dart';

class FormularioTransferencia extends StatefulWidget {
  final int? numeroConta;

  const FormularioTransferencia({super.key, this.numeroConta});

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  static const _tituloAppBar = 'Criando Transferência';
  static const _rotuloCampoValor = 'Valor';
  static const _dicaCampoValor = '0,00';
  static const _rotuloCampoNumeroConta = 'Número da conta';
  static const _dicaCampoNumeroConta = '0000';
  static const _textoBotaoConfirmar = 'Confirmar';

  @override
  void initState() {
    super.initState();
    if (widget.numeroConta != null) {
      _controladorCampoNumeroConta.text = widget.numeroConta.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: _rotuloCampoNumeroConta,
              dica: _dicaCampoNumeroConta,
              icone: Icons.numbers, // Adicionado conforme padrão do professor
              tipoTeclado: TextInputType.number,
            ),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.monetization_on,
              tipoTeclado: const TextInputType.numberWithOptions(decimal: true),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: const Text(_textoBotaoConfirmar),
                  onPressed: () => _criaTransferencia(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) async {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      try {
        await salvarTransferencia(transferenciaCriada);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Transferência salva com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao salvar: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos corretamente.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }
}