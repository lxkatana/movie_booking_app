import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MovieSeats(),
    );
  }
}

class BookingStatus {
  int seatId;
  bool isBooked;
  BookingStatus(this.seatId, this.isBooked);
}

class MovieSeats extends StatefulWidget {
  const MovieSeats({super.key});

  @override
  State<MovieSeats> createState() => _MovieSeatsState();
}

class _MovieSeatsState extends State<MovieSeats> {
  List<BookingStatus> seatStatus = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10),
              itemCount: 100,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                seatStatus.add(BookingStatus(index, false));
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: InkWell(
                    onTap: () {
                      seatStatus[index].isBooked = !seatStatus[index].isBooked;
                      setState(() {});
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      color: seatStatus[index].isBooked
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}