import 'package:flutter/material.dart';
import 'models.dart';
import './home_page.dart';
import 'registro_presenca_page.dart';
import 'relatorio_presenca_page.dart'; // Página de relatório de presença
import 'turma_page.dart';
import 'seletor_data_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Turma> _turmas = [
    Turma(
        id: '1',
        nome: 'Turma A',
        alunos: [Aluno(id: '1', nome: 'João'), Aluno(id: '2', nome: 'Maria')]),
    Turma(
        id: '2',
        nome: 'Turma B',
        alunos: [Aluno(id: '3', nome: 'Pedro'), Aluno(id: '4', nome: 'Ana')]),
  ];

  final Map<String, List<RegistroPresenca>> registrosPresenca = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Frequência de Alunos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(turmas: _turmas, registros: registrosPresenca),
      routes: {
        '/turmaPage': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return TurmaPage(turmas: args['turmas'], acao: args['acao']);
        },
        '/seletorData': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return SeletorDataPage(arguments: args);
        },
        '/registroPresenca': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return RegistroPresencaPage(
              turma: args['turma'],
              dataSelecionada: args['data'],
              registros: registrosPresenca);
        },
        '/relatorioPresenca': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return RelatorioPresencaPage(
              turma: args['turma'],
              dataSelecionada: args['data'],
              registros: registrosPresenca);
        },
      },
    );
  }
}
