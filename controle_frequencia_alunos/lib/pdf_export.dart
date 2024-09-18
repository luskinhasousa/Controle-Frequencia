import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'models.dart';

Future<void> exportarRelatorioEmPDF(Turma turma, List<RegistroPresenca> registros, DateTime dataSelecionada) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return [
          // Cabeçalho com os logos e informações principais
          pw.Header(
            level: 0,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DO PARÁ', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text('SISTEMA INTEGRADO DE GESTÃO DE ATIVIDADES ACADÊMICAS', style: pw.TextStyle(fontSize: 12)),
                pw.Text('LISTA DE FREQUÊNCIA', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          ),
          pw.SizedBox(height: 20),

          // Informação do curso, turma, data e docente
          pw.Text('Disciplina: ${turma.nome} - Programação de Computadores I'),
          pw.Text('Turma: ${turma.nome} (${turma.alunos.length} alunos)'),
          pw.Text('Data: ${dataSelecionada.toLocal().toString().split(' ')[0]}'),
          pw.SizedBox(height: 20),

          // Tabela com os dados dos alunos
          _buildTable(turma, registros, dataSelecionada),

          // Rodapé
          pw.Footer(
                title: pw.Text('Página 1 de 1'), 
              ),
        ];
      },
    ),
  );

  // Salvando o PDF
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

pw.Widget _buildTable(Turma turma, List<RegistroPresenca> registros, DateTime dataSelecionada) {
  return pw.Table.fromTextArray(
    headers: ['Nº', 'MATRÍCULA', 'NOME', 'ASSINATURA'],
    data: List<List<String>>.generate(turma.alunos.length, (index) {
      final aluno = turma.alunos[index];
      final registro = registros.firstWhere(
        (r) => r.alunoId == aluno.id && r.data == dataSelecionada,
        orElse: () => RegistroPresenca(alunoId: aluno.id, presente: false, data: dataSelecionada),
      );
      return [
        (index + 1).toString(), // Número
        aluno.id, // Matrícula
        aluno.nome, // Nome
        registro.presente ? 'Presente' : 'Ausente', // Assinatura
      ];
    }),
    border: pw.TableBorder.all(),
    cellAlignment: pw.Alignment.centerLeft,
    headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
    headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
    cellHeight: 30,
    cellAlignments: {
      0: pw.Alignment.center,
      1: pw.Alignment.centerLeft,
      2: pw.Alignment.centerLeft,
      3: pw.Alignment.center,
    },
  );
}
