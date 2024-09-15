import 'package:flutter/material.dart';
import 'models.dart'; // Importando os modelos
import 'registro_presenca_page.dart'; // Página de registro de presença
import 'relatorio_presenca_page.dart'; // Página de relatório de presença
import 'turma_page.dart'; // Página para selecionar turma
import 'home_page.dart'; // Página inicial com opções de registrar ou ver relatório

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Turma> _turmas = [
    Turma(
      id: '1',
      nome: 'Turma A',
      alunos: [
        Aluno(id: '1', nome: 'João'),
        Aluno(id: '2', nome: 'Maria'),
      ],
    ),
    Turma(
      id: '2',
      nome: 'Turma B',
      alunos: [
        Aluno(id: '3', nome: 'Pedro'),
        Aluno(id: '4', nome: 'Ana'),
      ],
    ),
  ];

  // Mapa para armazenar os registros de presença dos alunos
  Map<String, List<RegistroPresenca>> registrosPresenca = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Frequência de Alunos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(turmas: _turmas, registros: registrosPresenca), // Página inicial
      routes: {
        '/turmaPage': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return TurmaPage(turmas: args['turmas'], acao: args['acao']); // Página de seleção de turma
        },
        '/registroPresenca': (context) => RegistroPresencaPage(
            turma: ModalRoute.of(context)!.settings.arguments as Turma,
            registros: registrosPresenca),
        '/relatorioPresenca': (context) => RelatorioPresencaPage(
            turma: ModalRoute.of(context)!.settings.arguments as Turma,
            registros: registrosPresenca),
      },
    );
  }
}
