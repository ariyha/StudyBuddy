import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studybuddy/navbar.dart';
import 'package:clean_calendar/clean_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(),
      appBar: AppBar(
        title: const Text("Study Buddy"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SummaryContainer(title: "Assignments", subtitle: "10 Left"),
                  SummaryContainer(title: "Projects", subtitle: "5 Pending"),
                  SummaryContainer(title: "Tasks", subtitle: "2 Upcoming"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CleanCalendar(
                enableDenseViewForDates: true,
                datesForStreaks: [
                  DateTime(2022, 8, 5),
                  DateTime(2024, 8, 6),
                ],
                currentDateProperties: DatesProperties(
                  datesDecoration: DatesDecoration(
                    datesBorderRadius: 1000,
                    datesBackgroundColor: Colors.lightGreen.shade100,
                    datesBorderColor: Colors.green,
                    datesTextColor: Colors.black,
                  ),
                ),
                generalDatesProperties: DatesProperties(
                  datesDecoration: DatesDecoration(
                    datesBorderRadius: 1000,
                    datesBackgroundColor: Colors.lightGreen.shade100,
                    datesBorderColor: Colors.blue.shade100,
                    datesTextColor: Colors.black,
                  ),
                ),
                streakDatesProperties: DatesProperties(
                  datesDecoration: DatesDecoration(
                    datesBorderRadius: 1000,
                    datesBackgroundColor: Colors.green,
                    datesBorderColor: Colors.blue,
                    datesTextColor: Colors.white,
                  ),
                ),
                leadingTrailingDatesProperties: DatesProperties(
                  datesDecoration: DatesDecoration(
                    datesBorderRadius: 1000,
                  ),
                ),
              ),
            ),
            UpcomingAssignments(),
            UpcomingAssignments(),
          ],
        ),
      ),
    );
  }
}

class SummaryContainer extends StatelessWidget {
  final String title;
  final String subtitle;

  const SummaryContainer({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 80,
        width: 200,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16), // Add rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Add some padding
            child: Row(
              children: [
                const Icon(Icons.developer_board_rounded),
                const SizedBox(
                    width: 8), // Add some space between the icon and column
                Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the column
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).primaryTextTheme.titleMedium,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).primaryTextTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UpcomingAssignments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mock data for upcoming assignments (replace with actual data)
    List<String> assignments = [
      "Assignment 1",
      "Assignment 2",
      "Assignment 3",
      "Assignment 4",
      "Assignment 5",
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upcoming Assignments",
            style: Theme.of(context).primaryTextTheme.titleMedium,
          ),
          SizedBox(height: 12),
          Divider(color: Theme.of(context).colorScheme.onTertiary, height: 1),
          SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: assignments.map((assignment) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Icon(Icons.assignment, color: Colors.white),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          assignment,
                          style: Theme.of(context).primaryTextTheme.titleMedium,
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Due Date: July 15, 2024", // Replace with actual due date
                          style: Theme.of(context).primaryTextTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
