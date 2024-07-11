import 'package:flutter/material.dart';

class RickRollPage extends StatefulWidget {
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
        title: Text('Rolling in'),
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
