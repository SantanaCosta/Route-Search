import 'package:flutter/material.dart';
import 'package:route_search/view/routes_page.dart';
import 'package:route_search/view/stations_page.dart';

import '../controller/navigation_controler.dart';
import 'initial_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  late NavigationController _navigationController;

  final List<Widget> _pages = [
    const InitialPage(),
    const RoutesPage(),
    const StationsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _navigationController = NavigationController();
    _navigationController.setup(
      initialIndex: 0,
      onPageChanged: (index) {
        setState(() {
          // Atualize o estado do widget pai conforme necessário
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_navigationController.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _navigationController.navigateToPage,
          currentIndex: _navigationController.currentIndex,
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
