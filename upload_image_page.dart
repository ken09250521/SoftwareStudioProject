import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadImagePage extends StatefulWidget {
  const UploadImagePage({super.key});

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
          print(file.name);
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
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${fileSize[index]} byte',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 14,
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
          IconButton(
            onPressed: _pickFile, 
            icon: const Icon(Icons.add)
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}