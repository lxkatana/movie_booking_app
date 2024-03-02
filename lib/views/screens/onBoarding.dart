import 'package:flutter/material.dart';
import 'package:movie_booking/views/credentials/login.dart';

class onBoarding extends StatefulWidget {
  onBoarding({super.key});

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  void navigateToLogin(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Welcome to Cinema Hub",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 33,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Book tickets for your favourite shows !",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Image.asset(
              "assets/images/onBoardImg.jpeg",
              fit: BoxFit.cover,
              height: 400,
              width: double.infinity,
            ),
            SizedBox(
              height: 28,
            ),
            SizedBox(
                width: 240,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      navigateToLogin();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.blueAccent)),
                    child: Text(
                      "Next",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ))),
          ],
        ),
      ),
    ));
  }
}
