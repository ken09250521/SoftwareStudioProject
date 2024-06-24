import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme_setting_page.dart';
import 'package:camera/camera.dart';
import 'upload_image_page.dart';

class StartPage extends StatelessWidget {
  // const StartPage({super.key});
  final List<CameraDescription> cameras;
  const StartPage({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.primary,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Schedool',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              Text(
                'Time Manage Your Life',
                style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                    fontSize: 25,
                    
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context)=>UploadImagePage(cameras: cameras)),
                  );
                }, 
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.secondary, // 按鈕文本顏色
                  backgroundColor: Theme.of(context).colorScheme.onSecondary, // 按鈕背景顏色
                  textStyle: const TextStyle(fontSize: 20), // 按鈕文字大小
                ),
                child: const Text('Start!'),
              ),
            ],
        
        ),
      ),
    );
  }
} 