import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studybuddy/navbar.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<String> statusOptions = ['Pending', 'In Progress', 'Completed'];
  String dropdownvalue = 'Choose group';

  List<Map<String, String>> tasklist = [
    {"name": "JpElvQGQfHQmtChAJ", "status": "0", "assigned to": "Marian Wells"},
    {"name": "HAbLDB", "status": "1", "assigned to": "Linnie Green"},
    {"name": "OjBFaKyT", "status": "0", "assigned to": "Edna Bryant"},
    {
      "name": "GrgEvlhTyWrxXgkLbOoz",
      "status": "2",
      "assigned to": "Stephen Neal"
    },
    {"name": "MJDHHmvr", "status": "1", "assigned to": "Alan Bowman"},
    {"name": "LSNZCCuZAGyb", "status": "2", "assigned to": "Jeffery Welch"},
    {"name": "abfxD", "status": "0", "assigned to": "Nannie Fox"},
    {"name": "KBznVvwwp", "status": "0", "assigned to": "James Cross"},
    {
      "name": "lJcxFqqWljmUgOLxp",
      "status": "1",
      "assigned to": "Inez Maldonado"
    },
    {"name": "sXUtWNTRq", "status": "0", "assigned to": "Bill Jenkins"},
    {
      "name": "nDjFRxltOTMvCzHaoTc",
      "status": "1",
      "assigned to": "Stella Murray"
    },
    {"name": "CsrexaVKOB", "status": "2", "assigned to": "Trevor Norton"},
  ];

  // List of items in our dropdown menu
  var items = [
    'Choose group',
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
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20), // Button color
          ),
          child: Icon(Icons.add, size: 30),
          onPressed: () {
            setState(() {
              items.add('Item ${items.length + 1}');
            });
          }),
      bottomNavigationBar: Hero(
          tag: 'navbar',
          child: NavBar(
            currentPageIndex: 3,
          )),
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: const Text("Tasks"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      value: dropdownvalue,
                      icon:
                          const Icon(Icons.keyboard_double_arrow_down_rounded),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      style: Theme.of(context).primaryTextTheme.labelLarge,
                      underline: Container(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(value),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      child: Icon(Icons.add, size: 30),
                      onPressed: () {})
                ],
              ),
            ]),
            Expanded(
              child: ListView.builder(
                itemCount: tasklist.length,
                itemBuilder: (context, index) {
                  final task = tasklist[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: Colors.grey.shade800, width: 0.5),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.assignment_rounded),
                      title: Text(
                        task['name']!,
                        style: Theme.of(context).primaryTextTheme.labelLarge,
                      ),
                      subtitle: Text(
                        task['assigned to']!,
                        style: Theme.of(context).primaryTextTheme.labelSmall,
                      ),
                      trailing: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: statusOptions[int.parse(task['status']!)],
                          onChanged: (String? newValue) {
                            setState(() {
                              task['status'] =
                                  statusOptions.indexOf(newValue!).toString();
                            });
                          },
                          items: statusOptions
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
