import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class signInPage extends StatefulWidget {
  const signInPage({super.key});

  @override
  State<signInPage> createState() => _signInPageState();
}

class _signInPageState extends State<signInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_handleTextFields(), _handleButton()],
      ),
    );
  }

  Widget _handleTextFields() {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            border: OutlineInputBorder(),
            labelText: 'Email',
          ),
        ),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            border: OutlineInputBorder(),
            labelText: 'Senha',
          ),
        )
      ],
    );
  }

  Widget _handleButton() {
    return Row(
      children: [
        ElevatedButton(
          child: const Text('Sign Up'),
          onPressed: () => {},
        )
      ],
    );
  }
}
