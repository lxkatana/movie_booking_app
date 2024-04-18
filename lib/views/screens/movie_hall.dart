import 'package:flutter/material.dart';
import 'package:movie_booking/model/movie_show.dart';
import 'package:movie_booking/services/movie_services.dart';
import 'package:movie_booking/views/screens/seats.dart';

class MovieHall extends StatefulWidget {
  final int movieId;
  MovieHall({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieHall> createState() => _MovieHallState();
}

class _MovieHallState extends State<MovieHall> {
  late DateTime today;
  late DateTime tomorrow;
  int currentPageIndex = 1;

  late Future<List<MovieShow>> _movieShowsFuture;
  List<MovieShow>? _todayMovieShows;
  List<MovieShow>? _tomorrowMovieShows;

  Future<List<MovieShow>> _fetchFilteredMovieShows() async {
    // Fetch all movie shows for the specified movie ID
    List<MovieShow> allMovieShows =
        await MovieService.fetchMovieShowsByMovieId(widget.movieId);
    print("Movie Id data: " + widget.movieId.toString());
    // Get today's date and tomorrow's date
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    print("Today's Date: " + today.toString());
    print("Tomorrow's Date: " + tomorrow.toString());

    // Filter movie shows for today
    _todayMovieShows = allMovieShows.where((show) {
      DateTime showDate = DateTime.parse(show.date.toString());
      return showDate.isAtSameMomentAs(today);
    }).toList();

    // Filter movie shows for tomorrow
    _tomorrowMovieShows = allMovieShows.where((show) {
      DateTime showDate = DateTime.parse(show.date.toString());
      return showDate.isAtSameMomentAs(tomorrow);
    }).toList();

    print("Today's Movie Shows:");
    _todayMovieShows!.forEach((show) {
      print("Movie ID: ${show.movie.id}");
      print("Cinema ID: ${show.cinema.id}");
      print("Hall ID: ${show.hall.id}");
      print("Date: ${show.date}");
      print("Start Time: ${show.startTime}");
      print("Price: ${show.price.toString()}");
      // Print other relevant information as needed
    });

    print("\nTomorrow's Movie Shows:");
    _tomorrowMovieShows!.forEach((show) {
      print("Movie ID: ${show.movie.id}");
      print("Cinema ID: ${show.cinema.id}");
      print("Hall ID: ${show.hall.id}");
      print("Date: ${show.date}");
      print("Start Time: ${show.startTime}");
      print("Price: ${show.price.toString()}");
      // Print other relevant information as needed
    });

    return allMovieShows;
  }

  @override
  void initState() {
    super.initState();
    setDates();
    currentPageIndex = 1;
    _movieShowsFuture = _fetchFilteredMovieShows();
  }

  void setDates() {
    today = DateTime.now();
    tomorrow = today.add(Duration(days: 1));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Padding(
            padding: const EdgeInsets.only(right: 65.0),
            child: Center(
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
          ),
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 25),
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black87, Colors.black],
                  ),
                ),
                child: FutureBuilder<List<MovieShow>>(
                  future: _fetchFilteredMovieShows(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No movie data found'));
                    } else {
                      MovieShow firstMovieShow = snapshot.data!.first;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    firstMovieShow.movie.image ??
                                        'https://imgs.search.brave.com/Jp6ngmaC-F_2y5_7UN2IF8HtgALS20IY1-qn-o5x8EA/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzA0LzI5LzQyLzQy/LzM2MF9GXzQyOTQy/NDI3OV9kb2tFRndu/U29KZU9LcHF2VjF0/dFh1bThwaUVTc0Y1/TC5qcGc',
                                    height: 200,
                                    width: 165,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  height: 200,
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   "Movie Id: ${firstMovieShow.movie.id}",
                                      //   style: TextStyle(
                                      //     fontWeight: FontWeight.bold,
                                      //     fontSize: 22,
                                      //     color: Colors.white,
                                      //   ),
                                      // ),
                                      Text(
                                        "Title: ${firstMovieShow.movie.title}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Genre: ${firstMovieShow.movie.genre}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 19,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Duration: ${firstMovieShow.movie.durationInMinute} min",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentPageIndex = 1;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          currentPageIndex == 1 ? Colors.white : Colors.black,
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          currentPageIndex == 1 ? Colors.black : Colors.white,
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                      child: Text("Today"),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentPageIndex = 2;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          currentPageIndex == 2 ? Colors.white : Colors.black,
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          currentPageIndex == 2 ? Colors.black : Colors.white,
                        ),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                      child: Text("Tomorrow"),
                    ),
                  ),
                ],
              ),

              // Use FutureBuilder to build the UI based on the completion of _movieShowsFuture
              FutureBuilder<List<MovieShow>>(
                future: _movieShowsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while data is being fetched
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Show an error message if data fetching fails
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // If data fetching is successful, display the hall schedule based on the currentPageIndex
                    return currentPageIndex == 1
                        ? todaysHallSchedule()
                        : tomorrowsHallSchedule();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget todaysHallSchedule() {
    int? lastCinemaId;
    String? lastStartTime;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border(bottom: BorderSide(color: Colors.white, width: 0.8)),
          ),
          child: _todayMovieShows == null || _todayMovieShows!.isEmpty
              ? Text(
                  'No show time found',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _todayMovieShows!.length,
                  itemBuilder: (context, index) {
                    MovieShow movieShow = _todayMovieShows![index];
                    bool sameCinemaId = lastCinemaId == movieShow.cinema.id;
                    bool sameStartTime = lastStartTime == movieShow.startTime;
                    lastCinemaId = movieShow.cinema.id;
                    lastStartTime = movieShow.startTime;

                    // Skip displaying startTime if it's the same for the same cinema id
                    // if (sameCinemaId && sameStartTime) {
                    //   return SizedBox.shrink();
                    // }

                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!sameCinemaId)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movieShow.cinema.name,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      movieShow.cinema.address,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          SizedBox(height: 10),
                          if (!sameCinemaId)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  // Text("----Here is a gap---", style: TextStyle(color: Colors.white)),
                                  for (var movieShow in _todayMovieShows!)
                                    if (movieShow.cinema.id == lastCinemaId)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              // print("Movie Id: " +
                                              //     movieShow.id.toString());
                                              // print("Movie Name: " +
                                              //     movieShow.movie.title
                                              //         .toString());
                                              // print("Hall Id: " +
                                              //     movieShow.hall.id.toString());
                                              // print("Hall Name: " +
                                              //     movieShow.hall.name.toString());
                                              // print("Cinema Id: " +
                                              //     movieShow.cinema.id.toString());
                                              // print("Cinema Name: " +
                                              //     movieShow.cinema.name);
                                              // print("Start Time: " +
                                              //     movieShow.startTime);
                                              // print("Date: " +
                                              //     movieShow.date
                                              //         .toIso8601String());
                                              print("Start Time: " +
                                                  movieShow.startTime);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MovieSeats(
                                                          movieShow: movieShow),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                              ),
                                              child: Text(
                                                movieShow.startTime,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            movieShow.hall.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                  // Text("----Here is a gap---", style: TextStyle(color: Colors.white),),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget tomorrowsHallSchedule() {
    int? lastCinemaId;
    String? lastStartTime;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border(bottom: BorderSide(color: Colors.white, width: 0.8)),
          ),
          child: _tomorrowMovieShows == null || _tomorrowMovieShows!.isEmpty
              ? Text(
                  'No show time found',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: _tomorrowMovieShows!.length,
                  itemBuilder: (context, index) {
                    MovieShow movieShow = _tomorrowMovieShows![index];
                    bool sameCinemaId = lastCinemaId == movieShow.cinema.id;
                    bool sameStartTime = lastStartTime == movieShow.startTime;
                    lastCinemaId = movieShow.cinema.id;
                    lastStartTime = movieShow.startTime;

                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!sameCinemaId)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movieShow.cinema.name,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      movieShow.cinema.address,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          SizedBox(height: 10),
                          if (!sameCinemaId)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (var movieShow in _tomorrowMovieShows!)
                                    if (movieShow.cinema.id == lastCinemaId)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              print("Start Time: " +
                                                  movieShow.startTime);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MovieSeats(
                                                          movieShow: movieShow),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(12),
                                                ),
                                              ),
                                              child: Text(
                                                movieShow.startTime,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            movieShow.hall.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
