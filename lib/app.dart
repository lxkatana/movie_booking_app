import 'package:flutter/material.dart';
import 'package:movie_booking/views/screens/home.dart';
import 'package:movie_booking/views/screens/seats.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MovieSeats(),
    );
  }
}