import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../bloc/auth.dart';
import '../view/login_page.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;

  final bloc = AuthBloc();

  int get currentIndex => _currentIndex;

  void updateCurrentIndex(int index, context) {
    if (bloc.state is Authenticated) {
      _currentIndex = index;
      notifyListeners();
    } else if (bloc.state is Unauthenticated && index != 2) {
      _currentIndex = index;
      notifyListeners();
    } else if (bloc.state is Unauthenticated && index == 2) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text("Login obrigatório"),
              content: Text(
                  "É necessário estar logado para acessar a tela de estações."),
            );
          }).then((value) => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            )
          });
    }
  }
}
