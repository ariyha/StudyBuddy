import 'package:flutter/material.dart';
import 'package:studybuddy/navbar.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({super.key});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        child: Text('Hello'),
        onPressed: () {
          //TODO
        },
      ),
      bottomNavigationBar: NavBar(),
      appBar: AppBar(
        title: const Text("Assignments"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            AssignmentsList(
              items: items,
              dropdownvalue: dropdownvalue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AssignmentsList extends StatelessWidget {
  final List<String> items;
  final String dropdownvalue;
  final ValueChanged<String?> onChanged;

  const AssignmentsList({
    super.key,
    required this.items,
    required this.dropdownvalue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      // Initial Value
      value: dropdownvalue,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
