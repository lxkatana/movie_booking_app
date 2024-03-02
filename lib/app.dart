import 'package:flutter/material.dart';
import 'package:movie_booking/views/screens/movie_hall.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MovieHall(),
    );
  }
}