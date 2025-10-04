import 'package:flutter/material.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back Arrow + Title Row
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        "About Us",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // to balance space with back arrow
                  ],
                ),

                const SizedBox(height: 20),

                /// Instructor Section
                const Text(
                  "Instructed By:",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage("assets/images/instructor.jpg"),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Md Jamaner Rahman",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Lecturer",
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  "Department of CSE",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 28),

                /// Developer Section
                const Text(
                  "Developed By:",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                /// Sammun
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage("assets/images/sammun.jpg"),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Md Shahir Sammun",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Batch: 57",
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  "Department of CSE",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 23),

                /// Kamran
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage("assets/images/kamran.jpg"),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Md Kamran Hussen",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Batch: 57",
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  "Department of CSE",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 23),

                /// Nusrat
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage("assets/images/nusrat.jpg"),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Nusrat Jahan Shamantha",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Batch: 57",
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
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