import 'package:flutter/material.dart';

class ListsPage extends StatefulWidget {
  final List data;

  ListsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Abertos e Fechados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child: _handleListView(context)),
          ],
        ),
      ),
    );
  }

  Widget _handleListView(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.data.length; i++)
          for (int j = 0; j < widget.data[i].length; j++)
            for (int k = 0; k < widget.data[i][j].length; k++)
              // ignore: avoid_print
              Text(widget.data[i][j][k].name),
      ],
    );
  }
}
