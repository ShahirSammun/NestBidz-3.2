import 'package:flutter/material.dart';
import 'package:mobile_application6/ui/screens/reset_password.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'login_screen.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 94,
              ),
              Text(
                'PIN Verification',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'A 6 digit PIN will be sent to your email',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 24,
              ),
              PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  inactiveFillColor: Colors.white,
                  inactiveColor: Colors.red,
                  activeColor: Colors.white,
                  selectedColor: Colors.green,
                  selectedFillColor: Colors.white,
                  activeFillColor: Colors.white,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                cursorColor: Colors.black,
                enablePinAutofill: true,
                onCompleted: (v) {},
                onChanged: (value) {},
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");

                  return true;
                },
                appContext: context,
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
                              builder: (context) => const ResetPassword()));
                    }, child: const Text('Verify')),
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
