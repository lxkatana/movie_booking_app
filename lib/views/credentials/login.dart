import 'package:flutter/material.dart';
import 'package:movie_booking/views/credentials/register.dart';
import 'package:movie_booking/views/screens/home.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _gmail = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  void dispose() {
    _gmail.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 120),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _gmail,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
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
                        errorStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon: Icon(Icons.email),
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        hintText: "Gmail",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a valid password";
                        }
                        if (value.length < 8) {
                          return "Please enter an 8 character password";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(16),
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon: Icon(Icons.key),
                        prefixIconConstraints: BoxConstraints(minWidth: 45),
                        hintText: 'Password',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 280,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _onSubmit,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blueAccent),
                        ),
                        child: Text(
                          "Sign In",
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
                          "Don't have an account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 6),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue,
                              fontWeight: FontWeight.bold
                            ),
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
    );
  }
}
