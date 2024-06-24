import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:soft_studio_project/capture_page.dart';
import 'page_control.dart';
import 'package:camera/camera.dart';

enum Menu {file, camera}

class UploadImagePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const UploadImagePage({super.key, required this.cameras});

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  List<PlatformFile> files = [];
  List<String> fileNames = [];
  List<int> fileSize = [];
  bool isFile = false; 

  

  void _pickFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      // allowedExtensions: ['jpg', 'jpeg', 'png'], //dont know why adding this and the file manager
    );

    if (result != null) {
      setState(() {
        files.addAll(result.files);
        for(var file in result.files){
          fileNames.add(file.name);
          fileSize.add(file.size);
        }
      });

    } else {
      // User canceled the picker
    }
  }

  void _discardFile(int index){
    setState(() {
      files.removeAt(index);
      fileNames.removeAt(index);
      fileSize.removeAt(index);
    });
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
              itemCount: files.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${fileNames[index]}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${fileSize[index]} byte',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _discardFile(index), 
                        icon: const Icon(Icons.delete),
                        color: Colors.white,
                      ),
                    ],
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
                  (item == Menu.camera)
                    ? (){
                      print(item);
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context)=>UploadImagePage(cameras: widget.cameras)),
                      );
                    }
                    : _pickFile;
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