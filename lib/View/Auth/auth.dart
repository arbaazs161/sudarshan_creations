import 'package:flutter/material.dart';
import 'package:sudarshan_creations/Controller/authenticate.dart';

class auth extends StatefulWidget {
  const auth({super.key});

  @override
  State<auth> createState() => _authState();
}

class _authState extends State<auth> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isOtpVisible = false;
  AuthenticateController _authController = AuthenticateController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Enter Phone Number',
                hintText: 'e.g. +1234567890',
              ),
            ),
            SizedBox(height: 20),
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
              child: Text('Submit Phone Number'),
            ),
            SizedBox(height: 20),
            if (_isOtpVisible) ...[
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String otp = _otpController.text.trim();
                  // Call a method in AuthController to verify OTP
                  _authController.verifyCode(otp);
                },
                child: Text('Submit OTP'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

