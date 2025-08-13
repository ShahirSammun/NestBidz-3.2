import 'package:flutter/material.dart';
import 'package:mobile_application6/ui/screens/login_screen.dart';
import '../widget/screen_background.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 94,),
              Text(
                'Set Password',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Minimum length of password should be 8 character with letter and number combination',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 24,
              ),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              const TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    }, child: const Text('Confirm')),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Have an account?",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, letterSpacing: 0.5),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const LoginScreen()),
                                (route) => false);
                      },
                      child: const Text('Sign in')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
