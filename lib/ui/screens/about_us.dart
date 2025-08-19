import 'package:flutter/material.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Us",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: const ScreenBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Instructed By:",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage("assets/images/instructor.jpg"),
                ),
                SizedBox(height: 8),
                Text(
                  "Md Jamaner Rahman",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Lecturer",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Department of CSE",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 28),
                Text(
                  "Developed By:",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage("assets/images/sammun.jpg"),
                ),
                SizedBox(height: 8),
                Text(
                  "Md Shahir Sammun",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Batch: 57",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Department of CSE",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 23),

                CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage("assets/images/kamran.jpg"),
                ),
                SizedBox(height: 8),
                Text(
                  "Md Kamran Hussen",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Batch: 57",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Department of CSE",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 23),

                CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage("assets/images/nusrat.jpg"),
                ),
                SizedBox(height: 8),
                Text(
                  "Nusrat Jahan Shamantha",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Batch: 57",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Department of CSE",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}