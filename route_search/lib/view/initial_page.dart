import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Projeto de Mobile e IA',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Esse projeto tem como proposito nos ajudar a consolidar nosso conhecimentos nas disciplinas de Mobile e IA.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "Um app para testar buscas customizáveis com o algoritmo A*. Adicione estações, selecione as preferências de heurísticas e veja os caminhos serem trilhados!",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
