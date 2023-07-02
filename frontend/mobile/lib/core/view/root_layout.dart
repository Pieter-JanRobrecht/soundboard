import 'package:flutter/material.dart';

class RootLayout extends StatelessWidget {
  const RootLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soundboard'),
      ),
      body: child,
    );
  }
}
