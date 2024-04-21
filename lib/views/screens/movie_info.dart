import 'package:flutter/material.dart';
import 'package:movie_booking/model/movie.dart';
import 'package:movie_booking/services/movie_services.dart';
import 'package:movie_booking/views/screens/home.dart';
import 'package:movie_booking/views/screens/movie_hall.dart';

class MovieInfo extends StatefulWidget {
  final int movieId;

  MovieInfo({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  late Future<Movie> _futureMovie;

  @override
  void initState() {
    super.initState();
    _futureMovie = MovieService.fetchMovieInfo(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<Movie>(
          future: MovieService.fetchMovieInfo(widget.movieId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final Movie movie = snapshot.data!;
              return Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()));
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 32,
                                    ))),
                          ),
                          height: 460,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(movie.image ?? "https://imgs.search.brave.com/Jp6ngmaC-F_2y5_7UN2IF8HtgALS20IY1-qn-o5x8EA/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA0LzI5LzQyLzQy/LzM2MF9GXzQyOTQy/NDI3OV9kb2tFRndu/U29KZU9LcHF2VjF0/dFh1bThwaUVTc0Y1/TC5qcGc"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                            top: 432,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              // height: 500,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 12,
                                        bottom: 0,
                                        left: 24,
                                        right: 24),
                                    child: Column(
                                      children: [
                                        Container(
                                          // Rooms Details Container
                                          // height: 240,
                                          width: double.infinity,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      movie.title,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 28,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        "Ben Howling, Yolanda Ramke",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        "Genre: " + movie.genre,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        "Duration: " + movie.durationInMinute.toString() + " min",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    movie.description,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Button for Book Now
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 55,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => MovieHall(movieId: movie.id)));
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.grey),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Book Ticket',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Icon(
                                                    Icons.confirmation_number,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
