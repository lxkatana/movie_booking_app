import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_booking/const.dart';
import 'package:movie_booking/views/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _password = TextEditingController();
  TextEditingController _cpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String? _token;
  
  @override
  void initState() {
    super.initState();
    _getTokenFromSharedPreferences();
  }

  Future<void> _getTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 65.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Change Password",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Update your password by changing them here",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Form(
                    child: Column(
                  children: [
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
                      obscureText: true,
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
                    SizedBox(height: 16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          _changePassword(_token!, _password.text);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
                        child: Text(
                          'Change Password',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _changePassword(String token, String newPassword) async {
    try {
      print("Password: " + newPassword);
      final response = await http.post(
        Uri.parse(Constants.changePassword),
        headers: {
          'Authorization': 'Bearer $token', 
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'password': newPassword
        }),
      );
      print("Response: " + response.body);

      if (response.statusCode == 200) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        print('Password changed successfully');
      } else {
        // Password change failed, handle the error case
        print('Failed to change password: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors that occur during the API call
      print('Error changing password: $error');
    }
  }
}
