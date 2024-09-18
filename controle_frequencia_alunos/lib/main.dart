import 'package:flutter/material.dart';
import 'models.dart';
import './home_page.dart';
import 'registro_presenca_page.dart';
import 'relatorio_presenca_page.dart';
import 'turma_page.dart';
import 'seletor_data_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  // Inicializa a formatação de datas para pt_BR
  initializeDateFormatting('pt_BR').then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final List<Turma> _turmas = [
    Turma(
        id: '1',
        nome: 'Turma A - T383-2NB',
        alunos: [
                 Aluno(id: '1', nome: 'ADRIEL MENDES SILVA'),
                 Aluno(id: '2', nome: 'BRUNO NICHAEL FARIAS DAVID'),
                 Aluno(id: '3', nome: 'CHRYSTIAN GABRIEL MORAIS DE SOUSA'),
                 Aluno(id: '4', nome: 'D\'SILLAS CARVALHO DE OLIVEIRA'),
                 Aluno(id: '5', nome: 'ELIAS LIMA DA SILVA'),
                 Aluno(id: '6', nome: 'ELIONILSON VIANA DA SILVA'),
                 Aluno(id: '7', nome: 'FELIPE JEDIEL DE SOUZA OLIVEIRA'),
                 Aluno(id: '8', nome: 'GABRIEL DA SILVA'),
                 Aluno(id: '9', nome: 'HANDESON MILLER DE PAIVA ALVES'),
                 Aluno(id: '10', nome: 'HERALDO DOS SANTOS FERNANDES'),
                 Aluno(id: '11', nome: 'ICARO BRAZ BARBOSA'),
                 Aluno(id: '12', nome: 'JOÃO GILBERTO CAIRES FREIRE'),
                 Aluno(id: '13', nome: 'JÔNATAS LEÃO FURTADO'),
                 Aluno(id: '14', nome: 'JUCELINO HENRIQUE LOPES DE OLIVEIRA FILHO'),
                 Aluno(id: '15', nome: 'KAILANE VALDENORA GONÇALVES DE CARVALHO'),
                 Aluno(id: '16', nome: 'KEVIN ALENCAR COSTA'),
                 Aluno(id: '17', nome: 'LAURA SILVA ARAGÃO'),
                 Aluno(id: '18', nome: 'LEONARDO FERREIRA E SILVA'),
                 Aluno(id: '19', nome: 'LIANDRA CAROLINA SANTOS MORAIS'),
                 Aluno(id: '20', nome: 'LUAN SILVA DA ROCHA'),
                 Aluno(id: '21', nome: 'LUCAS SANTOS DE SOUSA'),
                 Aluno(id: '22', nome: 'MANNARYELLY GONÇALVES SANTOS SCARABELLI'),
                 Aluno(id: '23', nome: 'MANOEL REIS SOARES RODRIGUES JUNIOR'),
                 Aluno(id: '24', nome: 'MARCONDES COSTA DE OLIVEIRA'),
                 Aluno(id: '25', nome: 'MARCOS PAULO VEIGA'),
                 Aluno(id: '26', nome: 'MARONALDO CONCEIÇÃO DA SILVA'),
                 Aluno(id: '27', nome: 'MAURO EDUARDO MOTA LYRA'),
                 Aluno(id: '28', nome: 'MOISÉS ATANAENO GONÇALVES DE ANDRADE'),
                 Aluno(id: '29', nome: 'NICOLAS DA SILVA MOTA'),
                 Aluno(id: '30', nome: 'PEDRO HENRIQUE SOARES FRANÇA'),
                 Aluno(id: '31', nome: 'RAIANNE EVELLYN SOUZA FREITAS'),
                 Aluno(id: '32', nome: 'ROGER LUAN GUIMARÃES GOLTARA'),
                 Aluno(id: '33', nome: 'TALES SANTOS DE SOUZA'),
                 Aluno(id: '34', nome: 'THIAGO MELO LEÃO'),
                 Aluno(id: '35', nome: 'VALBER LOPES PEREIRA'),
                 Aluno(id: '36', nome: 'VANDERLEI DA CONCEIÇÃO BARBOSA'),
                 Aluno(id: '37', nome: 'VIVIAN PAOLA ALVES CARDOSO'),
                 Aluno(id: '38', nome: 'WILLEY FERREIRA PIMENTA'),
                 ]),
    Turma(
        id: '2',
        nome: 'Turma B - X',
        alunos: [Aluno(id: '3', nome: 'Pedro'), Aluno(id: '4', nome: 'Ana')]),
  ];

  final Map<String, List<RegistroPresenca>> registrosPresenca = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('pt', 'BR'),
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('pt', 'BR'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
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

