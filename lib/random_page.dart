import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_task.dart';
import 'page_control.dart';
import 'package:get/get.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});
  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  String randTask = '';

  String getRandomItem() {
    final random = Random();
    final taskController = Get.find<TaskController>();
    if (taskController.tasks.isNotEmpty){
      int index = random.nextInt(taskController.tasks.length);
      return taskController.tasks[index].title;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Text(randTask,
            style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                setState((){
                  randTask = getRandomItem();
                });
              }, 
              child: const Text('Get Random Task')),
          ],),
      )
    );
  }
}