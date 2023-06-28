import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:route_search/view/login_page.dart';
import 'package:route_search/view/routes_page.dart';
import 'package:route_search/view/stations_page.dart';

import '../bloc/auth.dart';
import '../controler/navigationprovider.dart';
import 'initial_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<_MyHomePageState> bottomNavControllerKey =
      GlobalKey<_MyHomePageState>();

  final bloc = AuthBloc();

  final List<Widget> _children = [
    const InitialPage(),
    const RoutesPage(),
    const StationsPage(),
  ];

  // void onTabTapped(int index) {
  //   if (bloc.state is AuthError) {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return const AlertDialog(
  //             title: Text("Erro do Firebase"),
  //           );
  //         });
  //   } else if (bloc.state is Authenticated) {
  //     setState(() {
  //       _currentIndex = index;
  //     });
  //   } else if (bloc.state is Unauthenticated && index != 2) {
  //     debugPrint("entrou");
  //     setState(() {
  //       _currentIndex = index;
  //     });
  //   } else if (bloc.state is Unauthenticated && index == 2) {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return const AlertDialog(
  //             title: Text("Login Obrigatorio"),
  //             content: Text(
  //                 "É obrigatorio estar logado para acessar a tela de Estações"),
  //           );
  //         }).then((value) => {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => const LoginPage(),
  //             ),
  //           )
  //         });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) => {},
        builder: (context, state) {
          return Consumer<NavigationProvider>(
              builder: (context, navigationProvider, _) {
            final currentIndex = navigationProvider.currentIndex;

            return Scaffold(
                body: _children[currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  onTap: (index) =>
                      navigationProvider.updateCurrentIndex(index, context),
                  currentIndex: currentIndex,
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
          });
        });
  }
}
