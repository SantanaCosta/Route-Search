import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class StationRegisterPage extends StatefulWidget {
  const StationRegisterPage({super.key});

  @override
  State<StationRegisterPage> createState() => _StationRegisterPageState();
}

class _StationRegisterPageState extends State<StationRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: const Center(child: Text(''),)
    );
      
  }
  
}