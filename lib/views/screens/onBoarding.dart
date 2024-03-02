import 'package:flutter/material.dart';
import 'package:movie_booking/views/screens/home.dart';

class onBoarding extends StatefulWidget {
  onBoarding({super.key});

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  void navigateToHome(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
                    fontSize: 32.1,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Book tickets to you're favourite movie !",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.5,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Image.asset(
              "assets/images/poster4.jpeg",
              fit: BoxFit.cover,
              height: 255,
              width: double.infinity,
            ),
            SizedBox(
              height: 28,
            ),
            SizedBox(
                width: 280,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      navigateToHome();
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
