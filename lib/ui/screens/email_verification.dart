import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_application6/ui/screens/login_screen.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final TextEditingController _emailController = TextEditingController();
  String? _emailError;
  bool _loading = false;

  Future<void> _sendResetLink() async {
    setState(() {
      _emailError = null;
    });

    String email = _emailController.text.trim();

    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@(gmail\.com|lus\.ac\.bd)$").hasMatch(email)) {
      setState(() {
        _emailError = "Please enter a valid email";
      });
      return;
    }

    try {
      setState(() => _loading = true);
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      // Show success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Reset link sent! Please check your inbox or spam folder."),
          backgroundColor: Colors.lightGreen,
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate back to LoginScreen after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message}")),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 94),
              Text(
                'Enter Email Address',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'A password reset link will be sent to your email',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Email TextField with validation
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  errorText: _emailError,
                  suffixIcon: _emailError != null
                      ? const Icon(Icons.warning, color: Colors.red)
                      : null,
                ),
              ),
              const SizedBox(height: 14),

              // Confirm button
              Center(
                child: ElevatedButton(
                  onPressed: _loading ? null : _sendResetLink,
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Submit'),
                ),
              ),
              const SizedBox(height: 6),

              // Sign in link
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
                        Navigator.pop(context);
                      },
                      child: const Text('Sign in')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}