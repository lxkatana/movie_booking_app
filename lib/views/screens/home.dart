import 'package:flutter/material.dart';
import 'dart:async';

import 'package:movie_booking/views/credentials/login.dart';
import 'package:movie_booking/views/screens/movie_info.dart';

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

  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startSliderTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startSliderTimer() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < imageAssetPaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(seconds: 3),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Cinema Hub',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.black,
          actions: <Widget>[
            PopupMenuButton(
              icon: Icon(Icons.more_vert, color: Colors.white,),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  child: SizedBox(
                    height: 35,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text('Logout', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.black38,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imageAssetPaths.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      imageAssetPaths[index],
                      fit: BoxFit.cover,
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 14.0, left: 20),
                  child: Text(
                    "Now Showing",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MovieInfo()),
                            );
                          },
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MovieInfo()));
                                },
                                child: Card(
                                  child: SizedBox(
                                    height: 240,
                                    width: 182,
                                    child: Image.asset(
                                      "assets/images/poster2.jpeg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4, bottom: 4),
                                child: Text(
                                  "Breaking Bad",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MovieInfo()),
                            );
                          },
                          child: Column(
                            children: [
                              Card(
                                child: SizedBox(
                                  height: 240,
                                  width: 182,
                                  child: Image.asset(
                                    "assets/images/poster1.jpeg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4, bottom: 4),
                                child: Text(
                                  "Avengers",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MovieInfo()),
                            );
                          },
                          child: Column(
                            children: [
                              Card(
                                child: SizedBox(
                                  height: 240,
                                  width: 182,
                                  child: Image.asset(
                                    "assets/images/poster3.jpeg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4, bottom: 4),
                                child: Text(
                                  "Spider Verse",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MovieInfo()),
                            );
                          },
                          child: Column(
                            children: [
                              Card(
                                child: SizedBox(
                                  height: 240,
                                  width: 182,
                                  child: Image.asset(
                                    "assets/images/poster4.jpeg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4, bottom: 4),
                                child: Text(
                                  "John Wick",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
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
