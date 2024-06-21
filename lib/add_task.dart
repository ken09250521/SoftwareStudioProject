// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'task_page.dart';

// List<Task> tasks = [];

// class AddTask extends StatefulWidget {
//   const AddTask({super.key});
//   @override
//   State<AddTask> createState() => _AddTaskState();
// }

// class _AddTaskState extends State<AddTask> {



//   final _formKey = GlobalKey<FormState>();
//   String? taskName;
//   String? description;
//   late DateTime selectedDate;
//   late TimeOfDay selectedTime;
//   int selectedHours = 0;
//   int selectedMinutes = 0;


//   final ValueNotifier<DateTime?> selectedDateNotifier = ValueNotifier<DateTime?>(null);

//   final ValueNotifier<TimeOfDay?> selectedTimeNotifier = ValueNotifier<TimeOfDay?>(null);

//   final titleController = TextEditingController();
//   final descController = TextEditingController();

//   bool showError = false;

//   void updateHours(int value) {
//     setState(() {
//       selectedHours = value;
//     });
//   }

//   void updateMinutes(int value) {
//     setState(() {
//       selectedMinutes = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context){
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
//       child: Form(
//         key: _formKey,
//         child: FractionallySizedBox(
//             widthFactor: 1.00,
//             heightFactor: 0.75,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 10),
//                       const Text(
//                         "Add Task",
//                         style: TextStyle(
//                           fontSize: 20,
//                         ),
//                         textAlign: TextAlign.left,
//                       ),
//                       const SizedBox(height: 10),
//                       const Divider(color: Colors.grey),
//                       TextFormField(
//                         controller: titleController,
//                         maxLength: 50,
//                         decoration: const InputDecoration(
//                           border: UnderlineInputBorder(),
//                           labelText: 'Enter Task Name',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty){
//                             return 'Please enter a task name';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 10),
//                       TextFormField(
//                           controller: descController,
//                           decoration: const InputDecoration(
//                             border: UnderlineInputBorder(),
//                             labelText: 'Enter Description',
//                           ),
//                           validator: (value){
//                             if (value == null || value.isEmpty){
//                               return 'Please enter a description';
//                             }
//                             return null;
//                           },
//                       ),
//                       const SizedBox(height: 30),
//                       Row(
                        
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           ValueListenableBuilder<DateTime?>(
//                             valueListenable: selectedDateNotifier,
//                             builder: (context, value, child) {
//                               return Text('Selected date: ${value != null ? DateFormat('yyyy-MM-dd').format(value) : 'No date selected'}');
//                             },
//                           ),
//                           ElevatedButton(
//                             child: const Icon(Icons.calendar_month),
//                             onPressed: () async {
//                               final DateTime? pickedDate = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime(2000),
//                                 lastDate: DateTime(2100),
//                               );
//                               if (pickedDate != null) {
//                                 setState((){
//                                   selectedDateNotifier.value = pickedDate;
//                                   selectedDate = pickedDate;
//                                 });
//                               }
//                             },
//                           ),
        
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           ValueListenableBuilder<TimeOfDay?>(
//                             valueListenable: selectedTimeNotifier,
//                             builder: (context, value, child) {
//                               return Text('Selected time: ${value != null ? value.format(context) : 'No Time Selected'}');
//                             },
//                           ),
                          
//                           ElevatedButton(
//                             child: const Icon(Icons.timer),
//                             onPressed: () async {
//                             final TimeOfDay? pickedTime = await showTimePicker(
//                               context: context,
//                               initialTime: TimeOfDay.now(),
//                             );
//                             if (pickedTime != null) {
//                               setState((){
//                                 selectedTimeNotifier.value = pickedTime;
//                                 selectedTime = pickedTime;
//                               });
//                             }
//                             },
//                           ),
        
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           DropdownButton<int>(
//                             value: selectedHours,
//                             items: List.generate(24, (index) => DropdownMenuItem(value: index, child: Text("$index hours"))),
//                             onChanged: (value) {
//                               if (value == null){
//                                 return;
//                               } else {
//                                 updateHours(value);
//                               }
//                             },
//                           ),
//                           DropdownButton<int>(
//                             value: selectedMinutes,
//                             items: List.generate(60, (index) => DropdownMenuItem(value: index, child: Text("$index minutes"))),
//                             onChanged: (int? value) {
//                               if (value == null){
//                                 return;
//                               } else {
//                                 updateMinutes(value);
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 100),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ElevatedButton(
//                             child: const Icon(Icons.close_outlined),
//                             onPressed: () {
//                                 // If the input is valid, close the modal bottom sheet
//                                 Navigator.pop(context);
//                             }
//                           ),
//                           ElevatedButton(
//                             child: const Icon(Icons.check_outlined),
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 if (selectedDateNotifier.value != null && selectedTimeNotifier.value != null) {
//                                   tasks.add(Task(
//                                     name: titleController.text,
//                                     description: descController.text,
//                                     date: selectedDateNotifier.value!,
//                                     time: selectedTimeNotifier.value!,
//                                     hours: selectedHours,
//                                     mins: selectedMinutes,
//                                 ));
//                                 // If the input is valid, close the modal bottom sheet
//                                 Navigator.pop(context);
//                               }
//                               }
//                             }
//                           ),
//                         ],
//                       ),          
        
//                     ],
//                   ),
//                 ),
//       ),
//     );
//   }
// }