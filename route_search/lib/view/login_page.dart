import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:route_search/view/signin_page.dart';

import '../bloc/auth.dart';
import '../controler/navigationprovider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bloc = AuthBloc();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_handleTextFields(), _handleButton(context)],
        ),
      ),
    );
  }

  Widget _handleTextFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              border: OutlineInputBorder(),
              labelText: 'Senha',
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () => {Navigator.popAndPushNamed(context, '/signin')},
          child: const Text('Cadastre-se'),
        ),
      ],
    );
  }

  Widget _handleButton(BuildContext context) {
    final navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: const Text('Login'),
          onPressed: () => {
            BlocProvider.of<AuthBloc>(context).add(LoginUser(
                username: _emailController.text,
                password: _passwordController.text)),
            bloc.stream.listen((event) => {
                  if (bloc.state is Authenticated)
                    {
                      navigationProvider.updateCurrentIndex(2, context),
                      Navigator.pop(context)
                    }
                })
          },
        )
      ],
    );
  }
}
