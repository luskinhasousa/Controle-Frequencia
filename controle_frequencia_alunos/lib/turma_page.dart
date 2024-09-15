import 'package:flutter/material.dart';
import 'models.dart';

class TurmaPage extends StatelessWidget {
  final List<Turma> turmas;
  final String acao; // A ação passada (registrar ou relatório)

  const TurmaPage({Key? key, required this.turmas, required this.acao}) : super(key: key);

  void _navegarParaAcao(BuildContext context, Turma turma) {
    if (acao == 'registrar') {
      Navigator.pushNamed(
        context,
        '/registroPresenca',
        arguments: turma,
      );
    } else if (acao == 'relatorio') {
      Navigator.pushNamed(
        context,
        '/relatorioPresenca',
        arguments: turma,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione uma Turma'),
      ),
      body: ListView.builder(
        itemCount: turmas.length,
        itemBuilder: (context, index) {
          final turma = turmas[index];
          return ListTile(
            title: Text(turma.nome),
            onTap: () {
              _navegarParaAcao(context, turma); // Navegar para a ação correta (registrar ou relatório)
            },
          );
        },
      ),
    );
  }
}
