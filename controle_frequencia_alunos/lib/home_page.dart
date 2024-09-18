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
        title: const Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Adiciona a imagem no topo
            Image.asset(
              'assets/images/logo_ponto.png', // Certifique-se de que esse caminho está correto
              width: 200, // Ajuste o tamanho conforme necessário
            ),
            const SizedBox(height: 40), // Espaço entre a imagem e os botões

            // Botão de Registrar Frequência
            ElevatedButton(
              onPressed: () {
                _navegarParaSelecaoDeTurma(context, 'registrar'); // Ação de registrar frequência
              },
              child: const Text('Registrar Frequência'),
            ),
            const SizedBox(height: 20), // Espaço entre os botões

            // Botão de Visualizar Relatório de Frequência
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
