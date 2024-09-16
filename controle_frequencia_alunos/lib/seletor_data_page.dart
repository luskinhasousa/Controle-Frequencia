import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models.dart';

class SeletorDataPage extends StatefulWidget {
  final Map<String, dynamic> arguments;

  const SeletorDataPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _SeletorDataPageState createState() => _SeletorDataPageState();
}

class _SeletorDataPageState extends State<SeletorDataPage> {
  DateTime _dataSelecionada = DateTime.now();

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _dataSelecionada) {
      setState(() {
        _dataSelecionada = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final turma = widget.arguments['turma'];
    final acao = widget.arguments['acao'];
    String dataFormatada = DateFormat('dd/MM/yyyy').format(_dataSelecionada);

    return Scaffold(
      appBar: AppBar(
        title: Text('Selecionar Data para Turma ${turma.nome}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Data Selecionada: $dataFormatada'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selecionarData(context),
              child: const Text('Selecionar Data'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (acao == 'registrar') {
                  // Navega para a tela de registro de presença se a ação for "registrar"
                  Navigator.pushNamed(
                    context,
                    '/registroPresenca',
                    arguments: {'turma': turma, 'data': _dataSelecionada},
                  );
                } else if (acao == 'relatorio') {
                  // Navega para a tela de relatório de presença se a ação for "relatorio"
                  Navigator.pushNamed(
                    context,
                    '/relatorioPresenca',
                    arguments: {'turma': turma, 'data': _dataSelecionada},
                  );
                }
              },
              child: Text(acao == 'registrar'
                  ? 'Confirmar Data e Registrar Frequência'
                  : 'Confirmar Data e Visualizar Relatório'),
            ),
          ],
        ),
      ),
    );
  }
}
