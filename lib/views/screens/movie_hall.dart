import 'package:flutter/material.dart';
import 'package:movie_booking/model/movie_show.dart';
import 'package:movie_booking/services/movie_services.dart';
import 'package:movie_booking/views/screens/home.dart';

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
      // Print other relevant information as needed
    });

    print("\nTomorrow's Movie Shows:");
    _tomorrowMovieShows!.forEach((show) {
      print("Movie ID: ${show.movie.id}");
      print("Cinema ID: ${show.cinema.id}");
      print("Hall ID: ${show.hall.id}");
      print("Date: ${show.date}");
      print("Start Time: ${show.startTime}");
      // Print other relevant information as needed
    });

    return allMovieShows;
  }

  @override
  void initState() {
    super.initState();
    setDates();
    _movieShowsFuture = _fetchFilteredMovieShows();
    currentPageIndex = 1;
  }

  void setDates() {
    today = DateTime.now();
    tomorrow = today.add(Duration(days: 1));
  }

  String getTodayString() {
    return "${today.year}-${today.month}-${today.day}";
  }

  String getTomorrowString() {
    return "${tomorrow.year}-${tomorrow.month}-${tomorrow.day}";
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                8), // Same as ClipRRect's borderRadius
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white
                                    .withOpacity(0.1), // Shadow color
                                spreadRadius: 2, // Spread radius
                                blurRadius: 5, // Blur radius
                                offset: Offset(0, 3), // Shadow offset
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "assets/images/poster2.jpeg",
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
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 10),
                            height: 200,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Movie Id: " + widget.movieId.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.white)),
                                Text("Breaking Bad",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: Colors.white)),
                                Text("Max Bellchrome",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19,
                                        color: Colors.white)),
                                Text("180 min",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        color: Colors.white)),
                                Text(
                                  "Todays Date: " + getTodayString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text("Tomorrow Date: " + getTomorrowString(),
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
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
              currentPageIndex == 1
                  ? todaysHallSchedule()
                  : tomorrowsHallSchedule(),
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
        Text(
          "Today's Hall Schedule",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          getTodayString(),
          style: TextStyle(color: Colors.white),
        ),
        Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border(bottom: BorderSide(color: Colors.white, width: 0.8)),
          ),
          child: _todayMovieShows?.isEmpty ?? true
              ? Text(
                  'No movie data found',
                  style: TextStyle(color: Colors.white),
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
                    if (sameCinemaId && sameStartTime) {
                      return SizedBox.shrink();
                    }

                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!sameCinemaId)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/poster1.jpeg",
                                  height: 75,
                                  width: 75,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movieShow.cinema.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      movieShow.cinema.address,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          SizedBox(height: 8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (var movieShow in _todayMovieShows!)
                                  if (movieShow.cinema.id == lastCinemaId)
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
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
        Text(
          "Tomorrow's Hall Schedule",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          getTomorrowString(),
          style: TextStyle(color: Colors.white),
        ),
        Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              border:
                  Border(bottom: BorderSide(color: Colors.white, width: 0.8)),
            ),
            child: _tomorrowMovieShows?.isEmpty ?? true
                ? Text(
                    'No movie data found',
                    style: TextStyle(color: Colors.white),
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

                      if (sameCinemaId && sameStartTime) {
                        return SizedBox.shrink();
                      }

                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (!sameCinemaId)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/poster1.jpeg",
                                    height: 75,
                                    width: 75,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movieShow.cinema.name,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        movieShow.cinema.address,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            SizedBox(height: 8),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (var movieShow in _tomorrowMovieShows!)
                                      if (movieShow.cinema.id == lastCinemaId)
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center, // Align items to the start horizontally
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(12),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    movieShow.startTime,
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
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
                                        )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    })),
      ],
    );
  }
}
