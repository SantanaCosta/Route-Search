import 'package:flutter/material.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/background.png',
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Um app para testar buscas customizáveis com o algoritmo A*. Adicione estações, selecione as preferências de heurísticas e veja os caminhos serem trilhados!",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto",
                      color: Colors.black,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(1.0, 1.0),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      )
    ]);
  }
}
