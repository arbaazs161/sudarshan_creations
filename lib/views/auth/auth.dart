import 'package:flutter/material.dart';

import '../../controller/auth_controller.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isOtpVisible = false;
  AuthenticateController _authController = AuthenticateController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Enter Phone Number',
                hintText: 'e.g. +1234567890',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String phoneNumber = _phoneController.text.trim();
                // Call the authenticate method from AuthController
                await _authController.userSignup(phoneNumber);

                // Show the OTP input field after the phone number is authenticated
                setState(() {
                  _isOtpVisible = true;
                });
              },
              child: const Text('Submit Phone Number'),
            ),
            const SizedBox(height: 20),
            if (_isOtpVisible) ...[
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter OTP',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String otp = _otpController.text.trim();
                  // Call a method in AuthController to verify OTP
                  _authController.verifyCode(otp);
                },
                child: const Text('Submit OTP'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
