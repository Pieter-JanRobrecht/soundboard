import 'package:flutter/material.dart';

class RootLayout extends StatelessWidget {
  const RootLayout({super.key, required this.children, required this.tabs});

  final List<IconData> tabs;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soundboard'),
        bottom: TabBar(
          tabs: tabs.map((e) => Tab(icon: Icon(e))).toList(),
        ),
      ),
      body: TabBarView(
        children: children,
      ),
    );
  }
}
