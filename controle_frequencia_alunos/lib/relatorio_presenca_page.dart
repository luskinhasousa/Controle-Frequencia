import 'package:flutter/material.dart';
import 'models.dart';

class RelatorioPresencaPage extends StatelessWidget {
  final Turma turma;
  final Map<String, List<RegistroPresenca>> registros;

  const RelatorioPresencaPage({Key? key, required this.turma, required this.registros}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatório de Frequência - ${turma.nome}'),
      ),
      body: ListView.builder(
        itemCount: turma.alunos.length,
        itemBuilder: (context, index) {
          final aluno = turma.alunos[index];
          final registrosAluno = registros[aluno.id] ?? [];
          final presencas = registrosAluno.where((r) => r.presente).length;
          final total = registrosAluno.length;
          final percentualPresenca = total > 0 ? (presencas / total) * 100 : 0.0;

          return ListTile(
            title: Text(aluno.nome),
            subtitle: Text('Presença: ${percentualPresenca.toStringAsFixed(2)}%'),
          );
        },
      ),
    );
  }
}
