import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:soft_studio_project/capture_page.dart';
import 'page_control.dart';
import 'package:camera/camera.dart';

enum Menu {file, camera}
class SubjectInfos{
  SubjectInfos({imagedirectories, files, required this.subjectName, required this.fileNums});

  String subjectName;
  List<PlatformFile> files=[]; // for files
  List<String> imageDirectories = []; // for images
  int fileNums;
}

class UploadImagePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const UploadImagePage({super.key, required this.cameras});

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  List<SubjectInfos> syllabus = []; //for files
  List<String> filesDirectory = []; //for images

  final subjectController = TextEditingController();

  void _pickFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        syllabus.add(SubjectInfos(
          files: result.files, 
          subjectName: subjectController.text, 
          fileNums: result.count
        ));
      });

    } else {
      // User canceled the picker
    }
  }

  void _discardFile(int index){
    setState(() {
      syllabus.removeAt(index);
    });
  }

  void _openCamera() async {
    List<String> filesDirectory = await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context)=>CapturePage(cameras: widget.cameras)),
    );
    print('[DEBUG] filesDirectory: ${filesDirectory.first}');
    syllabus.add(
      SubjectInfos(
        subjectName: subjectController.text, 
        fileNums: filesDirectory.length, 
        imagedirectories: filesDirectory
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Your Routine'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: syllabus.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '${syllabus[index].subjectName}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 50,),
                        Text(
                          '${syllabus[index].fileNums} files uploaded',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Do you want to delete the syllabus?'),
                                  actions: <Widget>[
                                    TextButton(
                                    child: const Text('Yes'),
                                    onPressed: () {
                                      _discardFile(index);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ],
                                );
                              },
                            );
                          }, 
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ],
                    ),
                  ]
                  ),
                );
              }
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton<Menu>(
                position: PopupMenuPosition.over,
                popUpAnimationStyle: AnimationStyle(
                          curve: Easing.emphasizedDecelerate,
                          duration: const Duration(seconds: 1),
                        ),
                icon: const Icon(Icons.add),
                onSelected: (Menu item) {
                  if(item == Menu.camera){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('What subject?'),
                          content: TextField(
                            controller: subjectController,
                            decoration: const InputDecoration(
                              labelText: 'subject name',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                _openCamera();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('What subject?'),
                          content: TextField(
                            controller: subjectController,
                            decoration: const InputDecoration(
                              labelText: 'subject name',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                _pickFile();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                  const PopupMenuItem<Menu>(
                    value: Menu.camera,
                    child: ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text('Camera'),
                    ),
                  ),
                  const PopupMenuItem<Menu>(
                    value: Menu.file,
                    child: ListTile(
                      leading: Icon(Icons.file_copy_rounded),
                      title: Text('File'),
                    ),
                  ),
                ]
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PageControl()),
                  );
                },
                child: const Text('Next'),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}