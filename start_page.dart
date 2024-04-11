import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schdool/upload_image_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      alignment: Alignment.center,
      child: SizedBox(
        height: 200.0,
        width: 400.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Its time to',
              style: GoogleFonts.dosis(
                textStyle: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              'Schdool',
              style: GoogleFonts.dosis(
                textStyle: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=>UploadImagePage()),
                );
              }, 
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // 按鈕文本顏色
                backgroundColor: Colors.blue, // 按鈕背景顏色
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