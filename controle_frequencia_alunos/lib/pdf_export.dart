import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'models.dart';  

Future<void> gerarRelatorioPDF(Turma turma, List<RegistroPresenca> registros) async {
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
              final registro = registros.firstWhere(
                  (r) => r.alunoId == aluno.id, orElse: () => RegistroPresenca(alunoId: aluno.id, data: DateTime.now(), presente: false));
              return pw.Text('${aluno.nome}: ${registro.presente ? 'Presente' : 'Ausente'}');
            }).toList(),
          ],
        );
      },
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File('${output.path}/relatorio_${turma.nome}.pdf');

  await file.writeAsBytes(await pdf.save());


  await Share.shareXFiles([XFile(file.path)], text: 'Relatório de Presença - ${turma.nome}');
}
