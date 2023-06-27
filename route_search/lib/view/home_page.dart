import 'package:flutter/material.dart';
import 'package:route_search/view/login_page.dart';
import 'package:route_search/view/routes_page.dart';
import 'package:route_search/view/stations_page.dart';

import '../bloc/auth.dart';
import 'initial_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = AuthBloc();

  int _currentIndex = 0;

  final List<Widget> _children = [
    const InitialPage(),
    const RoutesPage(),
    const StationsPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    bloc.stream.listen((state) {
      if (state is AuthError) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Erro do Firebase"),
                content: Text(state.message),
              );
            });
      } else if (state is Authenticated) {
        setState(() {
          _currentIndex = index;
        });
      } else if (state is Unauthenticated && index != 2) {
        debugPrint("entrou");
        setState(() {
          _currentIndex = index;
        });
      } else if (state is Unauthenticated && index == 2) {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("Login Obrigatorio"),
                content:
                    Text("É obrigatorio estar logado para acessar essa tela "),
              );
            });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              label: 'Rotas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.train),
              label: 'Estações',
            ),
          ],
        ));
  }
}
