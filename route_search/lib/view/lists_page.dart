import 'package:flutter/material.dart';

class ListsPage extends StatefulWidget {
  final List data;

  const ListsPage({Key? key, required this.data}) : super(key: key);

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Listas de abertos e fechados",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (widget.data.isNotEmpty)
                Row(
                  children: [
                    Expanded(
                      child: _buildList('Lista de Abertos', widget.data[0]),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                        child: _buildList('Lista de Fechados', widget.data[1])),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(String title, List items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 1,
          children: List.generate(items.length, (index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  items[index].map((item) => item.name).join(', '),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}
