import 'package:flutter/material.dart';
import 'models.dart';

class TurmaPage extends StatelessWidget {
  final List<Turma> turmas;
  final String acao; // Recebe a ação

  const TurmaPage({Key? key, required this.turmas, required this.acao}) : super(key: key);

  void _navegarParaSelecaoDeData(BuildContext context, Turma turma) {
    if (acao == 'registrar') {
      // Se a ação for registrar frequência
      Navigator.pushNamed(
        context,
        '/seletorData',
        arguments: {'turma': turma, 'acao': 'registrar'}, // Passa ação para selecionar data
      );
    } else if (acao == 'relatorio') {
      // Se a ação for visualizar relatório
      Navigator.pushNamed(
        context,
        '/seletorData',
        arguments: {'turma': turma, 'acao': 'relatorio'}, // Passa ação para selecionar data
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
              _navegarParaSelecaoDeData(context, turma); // Navega para a seleção de data
            },
          );
        },
      ),
    );
  }
}
