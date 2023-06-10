import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_search/view/home_page.dart';
import 'package:route_search/view/lists_page.dart';
import 'bloc/manage_bloc.dart';
import 'bloc/monitor.dart';
import 'bloc/states.dart';
import 'view/station_register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ManageBloc()),
          BlocProvider(create: (_) => MonitorBloc()),
        ],
        child: BlocListener<ManageBloc, ManageState>(
          listener: (context, state) {},
          child: MaterialApp(
            title: 'Route Search',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: Colors.indigoAccent,
                secondary: Colors.indigoAccent,
              ),
            ),
            home: const MyHomePage(title: 'Route Search'),
            initialRoute: '/',
            routes: {
              '/registro': (context) => const StationRegisterPage(),
            },
          ),
        ));
  }
}
