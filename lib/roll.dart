import 'package:flutter/material.dart';

class RickRollPage extends StatefulWidget {
  const RickRollPage({super.key});

  @override
  _RickRollPageState createState() => _RickRollPageState();
}

class _RickRollPageState extends State<RickRollPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rolling in'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
