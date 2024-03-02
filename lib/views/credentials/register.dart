import 'package:flutter/material.dart';
import 'package:movie_booking/views/credentials/login.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _username = TextEditingController();

  TextEditingController _gmail = TextEditingController();

  TextEditingController _password = TextEditingController();
  GlobalKey _formKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.only(left: 26, right: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/img1.jpeg', height: 180),
              SizedBox(
                height: 28,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextField(
                        controller: _username,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust border radius as needed
                            borderSide:
                                BorderSide(color: Colors.black), // Border color
                          ),
                          prefixIcon: Icon(Icons.person), // Icon added as prefix
                          prefixIconConstraints: BoxConstraints(minWidth: 45),
                          hintText: 'Username',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust border radius as needed
                            borderSide:
                                BorderSide(color: Colors.black), // Border color
                          ),
                        ),
                      ),
                         SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: _gmail,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust border radius as needed
                            borderSide:
                                BorderSide(color: Colors.black), // Border color
                          ),
                          prefixIcon: Icon(Icons.email), // Icon added as prefix
                          prefixIconConstraints: BoxConstraints(minWidth: 45),
                          hintText: "Gmail",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust border radius as needed
                            borderSide:
                                BorderSide(color: Colors.black), // Border color
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: _password,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust border radius as needed
                            borderSide:
                                BorderSide(color: Colors.black), // Border color
                          ),
                          prefixIcon: Icon(Icons.key), // Icon added as prefix
                          prefixIconConstraints: BoxConstraints(minWidth: 45),
                          hintText: 'Password',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust border radius as needed
                            borderSide:
                                BorderSide(color: Colors.black), // Border color
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                        controller: _password,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust border radius as needed
                            borderSide:
                                BorderSide(color: Colors.black), // Border color
                          ),
                          prefixIcon: Icon(Icons.key), // Icon added as prefix
                          prefixIconConstraints: BoxConstraints(minWidth: 45),
                          hintText: 'Confirm Password',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Adjust border radius as needed
                            borderSide:
                                BorderSide(color: Colors.black), // Border color
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: 280,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.blueAccent)),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              ))),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
