import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:studybuddy/navbar.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({super.key});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  List<String> items = [];
  String dropdownvalue = 'Choose class';
  List UserIDs = [];

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

  void getUsers() async {
    var db = FirebaseFirestore.instance;
    var uid = FirebaseAuth.instance.currentUser!.uid;

    var coll = await db.collection('users').get();
    UserIDs = coll.docs.map((doc) {
      var data = doc.data();
      return {"ID": doc.id, "name": data['displayName'], "chosen": false};
    }).toList();
  }

  void _showClassesFormDialog(BuildContext context) {
    String ClassName = '';
    String Description = '';
    String admin = FirebaseAuth.instance.currentUser!.uid;
    getUsers();
    print(UserIDs);
    var selectedUsers = [];

    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Add Class'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Assignment Name'),
                    onSaved: (value) => ClassName = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an assignment name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Description'),
                    onSaved: (value) => Description = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an assignment name';
                      }
                      return null;
                    },
                  ),
                  MultiSelectDropDown(
                    onOptionSelected: (options) {
                      selectedUsers = options;
                      debugPrint('$selectedUsers');
                    },
                    fieldBackgroundColor: Theme.of(context).primaryColor,
                    options: UserIDs.map((e) =>
                            ValueItem<String>(label: e['name'], value: e['ID']))
                        .toList(),
                  )
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            ));
  }

  void _showAssignmentFormDialog(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'New Assignment',
                            style:
                                Theme.of(context).primaryTextTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Assignment Name'),
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
                            decoration: const InputDecoration(
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
                                const InputDecoration(labelText: 'Description'),
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
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    // Handle form submission logic
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
                _showAssignmentFormDialog(context);
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
                        setState(() {
                          _showClassesFormDialog(context);
                        });
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
