import 'package:flutter/material.dart';

class ParametresPage extends StatefulWidget {
  final String title;
  const ParametresPage({super.key, required this.title});

  @override
  State<ParametresPage> createState() => _ParametresPageState();
}

class _ParametresPageState extends State<ParametresPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
        
        ),
      ),
    );
  }
}