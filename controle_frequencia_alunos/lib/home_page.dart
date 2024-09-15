import 'package:flutter/material.dart';
import 'models.dart'; // Certifique-se de que esse arquivo está no lugar correto

class HomePage extends StatelessWidget {
  final List<Turma> turmas;
  final Map<String, List<RegistroPresenca>> registros;

  const HomePage({Key? key, required this.turmas, required this.registros}) : super(key: key);

  void _navegarParaSelecaoDeTurma(BuildContext context, String acao) {
    // Navegar para a seleção de turma passando a ação desejada (registrar ou relatório)
    Navigator.pushNamed(
      context,
      '/turmaPage',
      arguments: {'turmas': turmas, 'acao': acao}, // Passa a ação escolhida e a lista de turmas
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de Frequência'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _navegarParaSelecaoDeTurma(context, 'registrar'); // Ação de registrar frequência
              },
              child: const Text('Registrar Frequência'),
            ),
            ElevatedButton(
              onPressed: () {
                _navegarParaSelecaoDeTurma(context, 'relatorio'); // Ação de visualizar relatório
              },
              child: const Text('Visualizar Relatório de Frequência'),
            ),
          ],
        ),
      ),
    );
  }
}
