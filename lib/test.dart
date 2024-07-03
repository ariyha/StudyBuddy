import 'package:flutter/material.dart';
import 'package:studybuddy/navbar.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String dropdownvalue = 'Choose class';

  List<Map<String, String>> testList = [
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

  // List of items in our dropdown menu
  var items = [
    'Choose class',
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
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
        ),
        child: const Icon(Icons.add, size: 30),
        onPressed: () {
          setState(() {
            items.add('Item ${items.length}');
          });
        },
      ),
      bottomNavigationBar: Hero(
        tag: 'navbar',
        child: NavBar(
          currentPageIndex: 2,
        ),
      ),
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: const Text("Tests"),
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
                    icon: const Icon(Icons.keyboard_double_arrow_down_rounded),
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
                    items: items.map<DropdownMenuItem<String>>((String value) {
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
                    // Add functionality here
                  },
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: testList.length,
                itemBuilder: (context, index) {
                  final user = testList[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: Colors.grey.shade800, width: 0.5),
                      ),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.assignment),
                      title: Text(
                        user['name']!,
                        style: Theme.of(context).primaryTextTheme.labelLarge,
                      ),
                      subtitle: Text(
                        user['date']!,
                        style: Theme.of(context).primaryTextTheme.labelSmall,
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
