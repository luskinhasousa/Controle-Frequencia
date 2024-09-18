import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'models.dart';

Future<void> exportarRelatorioEmTexto(Turma turma, Map<String, List<RegistroPresenca>> registros, DateTime dataSelecionada) async {
  // Gera o conteúdo do arquivo em texto
  final StringBuffer content = StringBuffer();
  content.writeln('Relatório de Frequência');
  content.writeln('Turma: ${turma.nome}');
  content.writeln('Data: ${dataSelecionada.toIso8601String().split('T')[0]}');
  content.writeln('');
  content.writeln('Matrícula | Nome | Presença');
  content.writeln('-' * 40);

  // Percorre a lista de alunos e verifica os registros de presença para cada um
  for (var aluno in turma.alunos) {
    final List<RegistroPresenca>? registrosAluno = registros[aluno.id];
    final registro = registrosAluno?.firstWhere(
      (r) => r.data == dataSelecionada,
      orElse: () => RegistroPresenca(alunoId: aluno.id, data: dataSelecionada, presente: false),
    );
    
    final status = registro?.presente == true ? 'Presente' : 'Ausente';
    content.writeln('${aluno.id} | ${aluno.nome} | $status');
  }

  // Obtém o diretório onde o arquivo será salvo
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/relatorio_frequencia_${turma.nome}_${dataSelecionada.toIso8601String().split('T')[0]}.txt';

  // Cria e salva o arquivo de texto
  final File file = File(filePath);
  await file.writeAsString(content.toString());

  // Compartilha o arquivo de texto gerado
  await Share.shareXFiles([XFile(file.path)], text: 'Relatório de Presença - ${turma.nome} (${dataSelecionada.toIso8601String().split('T')[0]})');
  
  print('Relatório salvo e compartilhado em $filePath');
}
