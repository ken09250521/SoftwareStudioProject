import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/task.dart';
import 'package:intl/intl.dart';
import 'page_control.dart';
import 'package:get/get.dart';
import 'calendar_page.dart';


class TaskPage extends StatefulWidget{
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  double urgencyLevel(RxList<Task> tasks, int idx){
    if(tasks[idx].urgency == UrgencyLevel.Low){
      return 0.4;
    } else if(tasks[idx].urgency == UrgencyLevel.Medium){
      return 0.5;
    } else if(tasks[idx].urgency == UrgencyLevel.High){
      return 0.6;
    } else if(tasks[idx].urgency == UrgencyLevel.Urgent){
      return 0.7;
    } else if(tasks[idx].urgency == UrgencyLevel.Immediate){
      return 0.8;
    } else{
      return 1.0;
    }
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _addNewEvent,
      // ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final taskController = Get.find<TaskController>();
              return ListView.builder(
                itemCount: taskController.tasks.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    onDismissed: (direction) {
                      setState(() {
                        taskController.tasks.removeAt(index);
                      });
                    },
                    key: UniqueKey(),
                    background: Card(
                      color: Theme.of(context).colorScheme.error,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Icon(Icons.delete_outlined, color: Colors.white,),
                          ],
                        ),
                      ),
                    ),
                    secondaryBackground: Card(
                      color: Theme.of(context).colorScheme.primary,
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.done, color: Colors.white,),
                            SizedBox(width: 10,),
                          ],
                        ),
                      ),
                    ),
                    child: Card(
                      color: (urgencyLevel(taskController.tasks, index)<=0.7)
                        ? Theme.of(context).colorScheme.primary.withOpacity(urgencyLevel(taskController.tasks, index))
                        : Theme.of(context).colorScheme.error.withOpacity(urgencyLevel(taskController.tasks, index)),
                      child: ListTile(
                        title: Text(taskController.tasks[index].title,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(taskController.tasks[index].title),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text('Description: ${taskController.tasks[index].description}'),
                                    ),
                                    ListTile(
                                      title: Text(DateFormat('yyyy-MM-dd').format(taskController.tasks[index].date)),
                                    ),
                                    ListTile(
                                      title: Text("Urgency Level:${taskController.tasks[index].urgency.toString().split('.').last}"),
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Close'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
