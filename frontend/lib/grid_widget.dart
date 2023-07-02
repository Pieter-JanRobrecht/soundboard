import 'package:flutter/material.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        _buildButton(color: Colors.teal[100]),
        _buildButton(color: Colors.teal[200]),
        _buildButton(color: Colors.teal[300]),
        _buildButton(color: Colors.teal[400]),
      ],
    );
  }

  ElevatedButton _buildButton({required Color? color}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: () => print('hello'),
        child: const Text('Press me'),
      );
  }
}
