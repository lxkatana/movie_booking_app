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
  int _currentPage = 0; // For Slider Page Navigation
  int _selectedIndex = 0; // For bottom screen Navigator

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

  void _startSliderTimer() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        if (_currentPage < imageAssetPaths.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
      });
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(seconds: 3),
        curve: Curves.easeOut,
      );
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (_selectedIndex) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Booking()),
        );
        break;
      default:
        break;
    }
  }

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
                  Navigator.pop(context);
                  MaterialPageRoute(builder: (context) => HomeScreen());
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
                    Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: imageAssetPaths.length,
                        itemBuilder: (_, index) {
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
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Image.network(
                                        movie.image ?? '',
                                        fit: BoxFit.cover,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          String errorMessage = '';
                                          if (exception
                                              is NetworkImageLoadException) {
                                            errorMessage =
                                                'Failed to load image: ${exception.statusCode} ${exception.uri}';
                                          } else {
                                            errorMessage =
                                                'Failed to load image: $exception';
                                          }
                                          // Show the specific error message
                                          return Center(
                                            child: Text(errorMessage),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4, bottom: 1),
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
                                  Padding(
                                    padding: EdgeInsets.only(top: 1, bottom: 4),
                                    child: Text(
                                      movie.genre,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
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
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.grey[300]),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people, color: Colors.grey[300]),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_movies, color: Colors.grey[300]),
              label: 'My Tickets',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[300],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
