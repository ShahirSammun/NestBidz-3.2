import 'package:flutter/material.dart';
import 'package:mobile_application6/ui/screens/login_screen.dart';
import 'package:mobile_application6/ui/screens/seller_homepage.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  List<bool> isSelected = [true, false]; // [Seller, Buyer]

  void _validateInputs() {
    setState(() {
      _nameError = null;
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;

      String name = _nameController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();

      if (name.isEmpty) {
        _nameError = "Please enter your name.";
      }

      if (!RegExp(r"^[a-zA-Z0-9._%+-]+@(gmail\.com|lus\.ac\.bd)$")
          .hasMatch(email)) {
        _emailError = "Please enter a valid email.";
      }

      if (!RegExp(r'^(?=.*[0-9])(?=.*[!@#%^&*]).{8,}$').hasMatch(password)) {
        _passwordError =
        "Password must be 8+ chars,\ninclude letter, number & symbol.";
      }

      if (confirmPassword != password) {
        _confirmPasswordError = "Passwords do not match.";
      }

      if (_nameError == null &&
          _emailError == null &&
          _passwordError == null &&
          _confirmPasswordError == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Signup Successful"),
            backgroundColor: Colors.lightGreen,
            duration: Duration(seconds: 2), // Show for 2 seconds
          ),
        );

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 17),

                  // Name
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      prefixIcon: const Icon(Icons.person),
                      errorText: _nameError,
                      suffixIcon: _nameError != null
                          ? const Icon(Icons.warning, color: Colors.red)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 17),

                  // Email
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      errorText: _emailError,
                      suffixIcon: _emailError != null
                          ? const Icon(Icons.warning, color: Colors.red)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 17),

                  // Password
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      errorText: _passwordError,
                      suffixIcon: _passwordError != null
                          ? const Icon(Icons.warning, color: Colors.red)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 17),

                  // Confirm Password
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      prefixIcon: const Icon(Icons.lock),
                      errorText: _confirmPasswordError,
                      suffixIcon: _confirmPasswordError != null
                          ? const Icon(Icons.warning, color: Colors.red)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Center(
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(8),
                      isSelected: isSelected,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < isSelected.length; i++) {
                            isSelected[i] = i == index;
                          }
                        });
                      },
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text("Seller"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text("Buyer"),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Signup button
                  Center(
                    child: ElevatedButton(
                      onPressed: _validateInputs,
                      child: const Text('Sign up'),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Sign in link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SellerHomePage(),
                            ),
                          );
                        },
                        child: const Text('Sign in'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}