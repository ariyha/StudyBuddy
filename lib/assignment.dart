import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studybuddy/navbar.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({super.key});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  List<String> items = [];
  String dropdownvalue = 'Choose class';

  List<Map<String, String>> userList = [
    {"name": "oNBisXaejQrgt", "date": "1/22/2058"},
    {"name": "sWTOldbzqeCTHbEEyM", "date": "12/21/2046"},
    {"name": "jaudGdgRlo", "date": "11/11/2069"},
    {"name": "qiZabZ", "date": "5/6/2080"},
    {"name": "QpFDCTrFHGWpwFzuohic", "date": "12/3/2108"},
    {"name": "lmJipfOdMxwUCgRZxNvo", "date": "12/16/2075"},
    {"name": "dZxDEdZJKAZBPQ", "date": "1/25/2106"},
    {"name": "uqQRrYO", "date": "10/2/2065"},
    {"name": "sunEpeDxn", "date": "7/9/2096"},
    {"name": "gRLPDtyreRalbvlxsoKr", "date": "5/1/2106"},
    {"name": "mTxxQVIZD", "date": "8/3/2082"},
    {"name": "roavCYpNSfOsM", "date": "5/24/2102"},
  ];

  void getClasses() async {
    var db = FirebaseFirestore.instance;
    var uid = FirebaseAuth.instance.currentUser!.uid;

    var userDoc = db.collection('users').doc(uid);
    await userDoc.get().then((value) {
      setState(() {
        items = List<String>.from(value['classes'] ?? []);
        if (items.isEmpty) {
          items = ['None'];
        }
        dropdownvalue = items[0];
      });
    });
  }

  void _showAssignmentFormDialog(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String assignmentName = '';
    DateTime? endDate;
    String description = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'New Assignment',
                            style: Theme.of(context).primaryTextTheme.headline6,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Assignment Name'),
                            onSaved: (value) => assignmentName = value!,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an assignment name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'End Date',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            readOnly: true,
                            onTap: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (selectedDate != null) {
                                setState(() {
                                  endDate = selectedDate;
                                });
                              }
                            },
                            controller: TextEditingController(
                              text: endDate == null
                                  ? ''
                                  : '${endDate!.year}-${endDate!.month}-${endDate!.day}',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select an end date';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Description'),
                            maxLines: 3,
                            onSaved: (value) => description = value!,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                child: const Text('Submit'),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    // Handle form submission logic
                                    print('Assignment Name: $assignmentName');
                                    print('End Date: $endDate');
                                    print('Description: $description');
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        getClasses();
        return Scaffold(
          floatingActionButton: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
            ),
            child: const Icon(Icons.add, size: 30),
            onPressed: () {
              setState(() {
                items.add('Item ${items.length}');
                print(items);
              });
            },
          ),
          bottomNavigationBar: Hero(
            tag: 'navbar',
            child: NavBar(
              currentPageIndex: 1,
            ),
          ),
          appBar: AppBar(
            scrolledUnderElevation: 0.0,
            title: const Text("Assignments"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        value: dropdownvalue,
                        icon: const Icon(
                            Icons.keyboard_double_arrow_down_rounded),
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
                      child: const Icon(Icons.add, size: 30),
                      onPressed: () {
                        _showAssignmentFormDialog(context);
                      },
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final user = userList[index];
                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Colors.grey.shade800, width: 0.5),
                          ),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.book_rounded),
                          title: Text(
                            user['name']!,
                            style:
                                Theme.of(context).primaryTextTheme.labelLarge,
                          ),
                          subtitle: Text(
                            user['date']!,
                            style:
                                Theme.of(context).primaryTextTheme.labelSmall,
                          ),
                          trailing: const Icon(Icons.chevron_right,
                              color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
