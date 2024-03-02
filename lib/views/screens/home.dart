import 'package:flutter/material.dart';
import 'dart:async';

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
        // Set _currentPage to 0 when reaching the last slide for a looping effect
        _currentPage = 0;

        _pageController.animateToPage(
          _currentPage,
          duration: Duration(seconds: 3),
          curve: Curves.easeOut,
        );
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(seconds: 3), // Adjust the duration as needed
        curve:
            Curves.easeOut, // Use an appropriate curve for the sliding effect
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
            'Movie',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
          )),
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.person), // Icon you want to place on the right
              onPressed: () {
                // Add your onPressed logic here
              },
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
                  padding:
                      const EdgeInsets.only(top: 15.0, bottom: 14.0, left: 20),
                  child: Text(
                    "Now Showing",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
              ),

              // ** NOW SHOWING DATES ---------------------------------

              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: generateDateWidgets(),
              //   ),
              // ),

              // ** NOW SHOWING MOVIES POSTERS ---------------------------------

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
                                MaterialPageRoute(
                                    builder: (context) => MovieInfo()));
                          },
                          child: Column(
                            children: [
                              Card(
                                child: SizedBox(
                                  height: 240,
                                  width: 182,
                                  child: Image.asset(
                                      "assets/images/poster2.jpeg",
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Text(
                                    "Breaking Bad",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieInfo()));
                          },
                          child: Column(
                            children: [
                              Card(
                                child: SizedBox(
                                  height: 240,
                                  width: 182,
                                  child: Image.asset(
                                      "assets/images/poster1.jpeg",
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Text(
                                    "Avengers",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ))
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
                                MaterialPageRoute(
                                    builder: (context) => MovieInfo()));
                          },
                          child: Column(
                            children: [
                              Card(
                                child: SizedBox(
                                  height: 240,
                                  width: 182,
                                  child: Image.asset(
                                      "assets/images/poster2.jpeg",
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Text(
                                    "Breaking Bad",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieInfo()));
                          },
                          child: Column(
                            children: [
                              Card(
                                child: SizedBox(
                                  height: 240,
                                  width: 182,
                                  child: Image.asset(
                                      "assets/images/poster1.jpeg",
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Text(
                                    "Avengers",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ))
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

  // * DATES WIDGITS FUNCTION:

  List<Widget> generateDateWidgets() {
    List<Widget> dateWidgets = [];
    DateTime today = DateTime.now();

    for (int i = -1; i <= 6; i++) {
      DateTime date = today.add(Duration(days: i));
      String formattedMonth = getShortMonth(date.month);
      String formattedDay = date.day.toString();

      dateWidgets.add(
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 86,
            width: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // color: Color.fromARGB(255, 84, 99, 107),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4E32A8), // Start color
                  Color(0xFF4197A4), // End color
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   height: 10,
                //   width: 10,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(50),
                //     color: Colors.black,
                //   ),
                // ),
                // SizedBox(height: 5),
                Text(
                  formattedMonth,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  formattedDay,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return dateWidgets;
  }

  String getShortMonth(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}
