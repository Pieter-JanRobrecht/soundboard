import 'package:flutter/material.dart';
import 'package:soundboard/grid_widget.dart';

class ButtonHomePage extends StatelessWidget {
  const ButtonHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Honk honk'),
      ),
      body: const GridWidget(),
    );
  }
}
