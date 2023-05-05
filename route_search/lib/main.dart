import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:route_search/view/home_page.dart';
import 'view/station_register_page.dart';

void main() async {
  await Hive.initFlutter();
  final routesBox = await Hive.openBox('routes');
  routesBox.put(0, '');
  routesBox.put(1, '');
  routesBox.put(2, 0.0);
  routesBox.put(3, 0.0);
  routesBox.put(4, 0.0);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Route Search'),
      initialRoute: '/',
      routes: {
        '/registro': (context) => const StationRegisterPage(),
      },
    );
  }
}
