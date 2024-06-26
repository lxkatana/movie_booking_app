import 'package:flutter/material.dart';
import 'package:movie_booking/model/user_model.dart';
import 'package:movie_booking/services/user_services.dart';
import 'package:movie_booking/views/credentials/login.dart';
import 'package:movie_booking/views/credentials/registerOtp.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _gmail = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _cpassword = TextEditingController();
  String error = '';
  final _formKey = GlobalKey<FormState>();

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      User user = User(
        name: _username.text,
        email: _gmail.text,
        password: _password.text,
        phone: _phone.text,
      );

      try {
        // Send OTP request
        bool sentOtp = await UserService.sendOTP(user.email);

        if (sentOtp) {
          // Navigate to OTP screen after OTP request is successful
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterOtpScreen(user: user),
            ),
          );
        } else {
          setState(() {
            error = "OTP sending failed ! Invalid email";
          });
        }
      } catch (e) {
        // Handle error
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Image.asset('assets/images/logo.png', height: 120),
                  SizedBox(height: 28),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _username,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            }
                            if (value.length < 5) {
                              return 'Please enter more than 5 characters for the username';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            filled: true,
                            fillColor: Colors.white,
                            errorStyle: TextStyle(
                                color: Colors
                                    .white), // Set the error message color to white
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            prefixIcon: Icon(Icons.person),
                            prefixIconConstraints: BoxConstraints(minWidth: 45),
                            hintText: 'Username',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            filled: true,
                            fillColor: Colors.white,
                            errorStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            prefixIcon: Icon(Icons.call),
                            prefixIconConstraints: BoxConstraints(minWidth: 45),
                            hintText: 'Phone',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _gmail,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            filled: true,
                            fillColor: Colors.white,
                            errorStyle: TextStyle(
                                color: Colors
                                    .white), // Set the error message color to white
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            prefixIcon: Icon(Icons.email),
                            prefixIconConstraints: BoxConstraints(minWidth: 45),
                            hintText: 'Gmail',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        error.isNotEmpty
                            ? Text(
                                error,
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                                textAlign: TextAlign.start,
                              )
                            : SizedBox(),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _password,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid password';
                            }
                            if (value.length < 8) {
                              return 'Please enter an 8 character password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            filled: true,
                            fillColor: Colors.white,
                            errorStyle: TextStyle(
                                color: Colors
                                    .white), // Set the error message color to white
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            prefixIconConstraints: BoxConstraints(minWidth: 45),
                            hintText: 'Password',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _cpassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid password';
                            }
                            if (value.length < 8) {
                              return 'Please enter an 8 character password';
                            }
                            if (value != _password.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            filled: true,
                            fillColor: Colors.white,
                            errorStyle: TextStyle(
                                color: Colors
                                    .white), // Set the error message color to white
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            prefixIconConstraints: BoxConstraints(minWidth: 45),
                            hintText: 'Confirm Password',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _onSubmit,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blueAccent),
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 6),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
