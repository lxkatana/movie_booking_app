import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_booking/model/movie.dart';
import 'package:movie_booking/views/credentials/login.dart';
import 'package:movie_booking/views/screens/booking.dart';
import 'package:movie_booking/views/screens/movie_info.dart';
import 'package:movie_booking/services/movie_services.dart';
import 'package:movie_booking/views/screens/user_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imageAssetPaths = [
    'assets/images/poster3.jpeg',
    'assets/images/poster4.jpeg',
    'assets/images/poster5.jpeg',
    'assets/images/poster2.jpeg',
  ];

  final PageController _pageController = PageController();
  late Future<List<Movie>> _futureMovies;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // _startSliderTimer();
    _futureMovies = MovieService.fetchMovies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // void _startSliderTimer() {
  //   Timer.periodic(Duration(seconds: 3), (timer) {
  //     setState(() {
  //       if (_currentPage < imageAssetPaths.length - 1) {
  //         _currentPage++;
  //       } else {
  //         _currentPage = 0;
  //       }
  //     });
  //     _pageController.animateToPage(
  //       _currentPage,
  //       duration: Duration(seconds: 3),
  //       curve: Curves.easeOut,
  //     );
  //   });
  // }

  static Future<void> removeTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
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
          backgroundColor: Colors.black,
          actions: <Widget>[
            PopupMenuButton(
              icon: Icon(Icons.more_vert, color: Colors.white),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () async {
                      await removeTokenFromSharedPreferences();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          iconTheme: IconThemeData(color: Colors.white),
        ),
        backgroundColor: Colors.black38,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Center(
                    child: Image.asset("assets/images/logo.png",
                        height: 78, width: 78)),
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.home),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Home',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                onTap: () {
                  // Handle item 1 tap
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.people_alt),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Profile',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.local_play_outlined),
                    SizedBox(
                      width: 8,
                    ),
                    Text('My Tickets',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Booking()));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
              SizedBox(
                height: 32,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 20),
              //   child: Align(
              //       alignment: Alignment.bottomCenter,
              //       child: Text("@ Copyright 2022 CinemaHub")),
              // )
            ],
          ),
        ),
        body: FutureBuilder<List<Movie>>(
          future: _futureMovies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error in UI: ${snapshot.error.toString()}'));
            } else {
              final List<Movie> movies = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   height: 250,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: PageView.builder(
                    //     controller: _pageController,
                    //     itemCount: imageAssetPaths.length,
                    //     itemBuilder: (_, index) {
                    //       return Image.asset(
                    //         imageAssetPaths[index],
                    //         fit: BoxFit.cover,
                    //       );
                    //     },
                    //     onPageChanged: (index) {
                    //       setState(() {
                    //         _currentPage = index;
                    //       });
                    //     },
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 12, 0, 6),
                      child: Text(
                        "Now Showing",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        for (final movie in movies)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        MovieInfo(movieId: movie.id)),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Card(
                                    child: SizedBox(
                                        height: 240,
                                        width: 178,
                                        child: Image.network(
                                          movie.image ??
                                              "https://imgs.search.brave.com/Jp6ngmaC-F_2y5_7UN2IF8HtgALS20IY1-qn-o5x8EA/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA0LzI5LzQyLzQy/LzM2MF9GXzQyOTQy/NDI3OV9kb2tFRndu/U29KZU9LcHF2VjF0/dFh1bThwaUVTc0Y1/TC5qcGc",
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4, bottom: 4),
                                    child: Text(
                                      movie.title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
