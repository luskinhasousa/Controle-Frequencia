import 'package:flutter/material.dart';
import 'models.dart';

class RelatorioPresencaPage extends StatelessWidget {
  final Turma turma;
  final DateTime dataSelecionada;
  final Map<String, List<RegistroPresenca>> registros;

  const RelatorioPresencaPage({Key? key, required this.turma, required this.dataSelecionada, required this.registros}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<RegistroPresenca> registrosTurma = [];

    // Função para comparar datas ignorando a hora
    bool _mesmaData(DateTime data1, DateTime data2) {
      return data1.year == data2.year &&
             data1.month == data2.month &&
             data1.day == data2.day;
    }

    // Itera sobre os alunos da turma
    for (var aluno in turma.alunos) {
      if (registros.containsKey(aluno.id)) {
        // Itera sobre os registros de presença do aluno e adiciona aqueles que correspondem à data selecionada
        for (var registro in registros[aluno.id]!) {
          if (_mesmaData(registro.data, dataSelecionada)) {
            registrosTurma.add(registro);
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Relatório de Frequência - ${turma.nome}'),
      ),
      body: registrosTurma.isEmpty
          ? Center(
              child: Text('Nenhum registro encontrado para a data ${dataSelecionada.day}/${dataSelecionada.month}/${dataSelecionada.year}.'),
            )
          : ListView.builder(
              itemCount: registrosTurma.length,
              itemBuilder: (context, index) {
                final registro = registrosTurma[index];
                final aluno = turma.alunos.firstWhere((aluno) => aluno.id == registro.alunoId);
                return ListTile(
                  title: Text(aluno.nome),
                  subtitle: Text(registro.presente ? 'Presente' : 'Ausente'),
                );
              },
            ),
    );
  }
}
