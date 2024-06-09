import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_task.dart';
import 'package:intl/intl.dart';

class TaskPage extends StatefulWidget{
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(), // Empty container to remove the default back button
        title: Text(
          'Task List',
          style: GoogleFonts.openSans(),
          ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(tasks[index].name),
                    subtitle: Text(tasks[index].description),
                    trailing: Container(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(DateFormat('yyyy-MM-dd').format(tasks[index].date)),
                          Text(tasks[index].time.format(context)),
                        ],),
                    )
                    
                    // Add more properties as needed
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Task {
  Task({
      required this.name,
      required this.description,
      required this.date,
      required this.time,
      required this.hours,
      required this.mins
});

  final String name;
  final String description;
  final DateTime date;
  final TimeOfDay time;
  final int hours;
  final int mins;
}
