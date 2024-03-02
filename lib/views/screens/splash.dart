import 'package:flutter/material.dart';
import 'dart:async';

import 'package:movie_booking/views/screens/onBoarding.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 8 seconds until navigate to the next page !
    Timer(Duration(seconds: 8), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => onBoarding()),
      );
    });
  }
  
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png', height: 130, width: double.infinity,),
          SizedBox(height: 28,),
          CircularProgressIndicator()
        ],
      ),

    ));
  }
}
