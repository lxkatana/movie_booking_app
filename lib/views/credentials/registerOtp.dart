import 'package:flutter/material.dart';
import 'package:movie_booking/model/user_model.dart';
import 'package:movie_booking/services/user_services.dart';

import 'package:movie_booking/const.dart';
import 'package:movie_booking/views/credentials/login.dart';

class RegisterOtpScreen extends StatefulWidget {
  final User user;

  RegisterOtpScreen({required this.user});

  @override
  _RegisterOtpScreenState createState() => _RegisterOtpScreenState();
}

class _RegisterOtpScreenState extends State<RegisterOtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final String finalUrl = Constants.baseUrl + Constants.registerUrl;
  String errorMessage = '';

  void _onSubmit() async {
    String otp = _otpController.text.trim();
    try {
      print("Name: " + widget.user.name);
      print("Password: " + widget.user.password);
      print("Email: " + widget.user.email);
      print("Phone: " + widget.user.phone);
      print("OTP: " + otp);

      // Register user with OTP
      bool isRegistered = await UserService.registerUser(widget.user, otp);

      if (isRegistered) {
        // User registered successfully
        print('User registered successfully');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        // Registration failed
        print('Failed to register user');
        setState(() {
          errorMessage = 'Failed to register user';
        });
      }
    } catch (e) {
      print('Error: $e');
      // Handle the case where an error occurs
      setState(() {
        errorMessage = 'An error occurred. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'OTP Verification',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 18),
            TextField(
              controller: _otpController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'OTP',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Enter OTP',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            errorMessage.isNotEmpty
                ? Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                : SizedBox(),
            ElevatedButton(
              onPressed: _onSubmit,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
