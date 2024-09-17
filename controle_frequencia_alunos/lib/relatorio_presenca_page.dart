import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'models.dart'; 

class RelatorioPresencaPage extends StatelessWidget {
  final Turma turma;
  final DateTime dataSelecionada;
  final Map<String, List<RegistroPresenca>> registros;

  RelatorioPresencaPage({Key? key, required this.turma, required this.dataSelecionada, required this.registros}) : super(key: key);

  bool mesmaData(DateTime data1, DateTime data2) {
    return data1.year == data2.year && data1.month == data2.month && data1.day == data2.day;
  }

  Future<void> exportarRelatorioPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Relatório de Presença - ${turma.nome}', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 10),
              ...turma.alunos.map((aluno) {
                final registro = registros[aluno.id]?.firstWhere(
                      (r) => mesmaData(r.data, dataSelecionada),
                      orElse: () => RegistroPresenca(alunoId: aluno.id, data: dataSelecionada, presente: false),
                    ) ??
                    RegistroPresenca(alunoId: aluno.id, data: dataSelecionada, presente: false);
                return pw.Text('${aluno.nome}: ${registro.presente ? 'Presente' : 'Ausente'}');
              }).toList(),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/relatorio_${turma.nome}_${dataSelecionada.toIso8601String()}.pdf');

    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles([XFile(file.path)], text: 'Relatório de Presença - ${turma.nome}');
  }

  @override
  Widget build(BuildContext context) {
    List<RegistroPresenca> registrosTurma = [];

    for (var aluno in turma.alunos) {
      if (registros.containsKey(aluno.id)) {
  
        var registroAluno = registros[aluno.id]!.firstWhere(
          (registro) => mesmaData(registro.data, dataSelecionada),
          orElse: () => RegistroPresenca(alunoId: aluno.id, data: dataSelecionada, presente: false), 
        );
        registrosTurma.add(registroAluno);
      } else {
        
        registrosTurma.add(RegistroPresenca(alunoId: aluno.id, data: dataSelecionada, presente: false));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Relatório de Frequência - ${turma.nome}'),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () {
              exportarRelatorioPDF(); 
            },
          ),
        ],
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
