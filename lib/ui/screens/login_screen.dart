import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_application6/ui/screens/Buyer_homePage.dart';
import 'package:mobile_application6/ui/screens/Seller_homePage.dart';
import 'package:mobile_application6/ui/screens/email_verification.dart';
import 'package:mobile_application6/ui/screens/signup_screen.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  bool _loading = false;

  Future<void> _validateAndLogin() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@(gmail\.com|lus\.ac\.bd)$")
        .hasMatch(email)) {
      setState(() => _emailError = "Please enter a valid email");
      return;
    }

    if (password.isEmpty) {
      setState(() => _passwordError = "Password cannot be empty");
      return;
    }

    try {
      setState(() => _loading = true);

      // Firebase Login
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Fetch user info from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        throw Exception("User data not found in Firestore");
      }

      String role = userDoc["role"];
      String name = userDoc["name"];

      // Show welcome back message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Welcome back, $name!"),
          backgroundColor: Colors.lightGreen,
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigate based on role after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (role == "Seller") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SellerHomePage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${e.message}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unexpected error: $e")),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('NESTBIDZ', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),

                // Email
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    errorText: _emailError,
                  ),
                ),
                const SizedBox(height: 12),

                // Password
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    errorText: _passwordError,
                  ),
                ),
                const SizedBox(height: 16),

                // Sign In button
                Center(
                  child: ElevatedButton(
                    onPressed: _loading ? null : _validateAndLogin,
                    child: _loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Sign in'),
                  ),
                ),
                const SizedBox(height: 14),

                // Forgot Password
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmailVerification(),
                      ),
                    );
                  },
                  child: const Text('Forgot Password?'),
                ),

                const SizedBox(height: 12),

                // Signup link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()),
                        );
                      },
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}