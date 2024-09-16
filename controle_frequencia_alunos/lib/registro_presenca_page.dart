import 'package:flutter/material.dart';
import 'models.dart';

class RegistroPresencaPage extends StatefulWidget {
  final Turma turma;
  final DateTime dataSelecionada;
  final Map<String, List<RegistroPresenca>> registros;

  const RegistroPresencaPage({Key? key, required this.turma, required this.dataSelecionada, required this.registros}) : super(key: key);

  @override
  _RegistroPresencaPageState createState() => _RegistroPresencaPageState();
}

class _RegistroPresencaPageState extends State<RegistroPresencaPage> {
  Map<String, bool> presencaStatus = {};

  @override
  void initState() {
    super.initState();
    for (final aluno in widget.turma.alunos) {
      presencaStatus[aluno.id] = false; // Todos ausentes por padrão
    }
  }

  void salvarPresenca() {
    for (final aluno in widget.turma.alunos) {
      final presente = presencaStatus[aluno.id] ?? false;

      if (widget.registros[aluno.id] == null) {
        widget.registros[aluno.id] = [];
      }

      // Garantir que a data seja salva sem a hora (definida como meia-noite)
      final dataAjustada = DateTime(widget.dataSelecionada.year, widget.dataSelecionada.month, widget.dataSelecionada.day);

      widget.registros[aluno.id]!.add(RegistroPresenca(
        alunoId: aluno.id,
        data: dataAjustada, // Usa a data ajustada sem a hora
        presente: presente,
      ));
    }

    debugPrint("Presença salva para a turma ${widget.turma.nome} na data ${widget.dataSelecionada}");
    Navigator.pop(context); // Retorna à página anterior após salvar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Presença - ${widget.turma.nome}'),
      ),
      body: ListView.builder(
        itemCount: widget.turma.alunos.length,
        itemBuilder: (context, index) {
          final aluno = widget.turma.alunos[index];
          return ListTile(
            title: Text(aluno.nome),
            trailing: Switch(
              value: presencaStatus[aluno.id] ?? false,
              onChanged: (value) {
                setState(() {
                  presencaStatus[aluno.id] = value;
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: salvarPresenca,
        child: const Icon(Icons.save),
      ),
    );
  }
}
