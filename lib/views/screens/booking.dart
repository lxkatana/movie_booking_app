import 'package:flutter/material.dart';
import 'package:movie_booking/services/reservation_services.dart';
import 'package:movie_booking/views/screens/home.dart';
import 'package:movie_booking/model/reservation_model.dart'; // Import your reservation model

class Booking extends StatefulWidget {
  Booking({this.pidx, super.key});
  final String? pidx;

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final ReservationService _reservationService = ReservationService();
  List<Reservation> _userReservations = [];

  @override
  void initState() {
    super.initState();
    _fetchUserReservations();
  }

  Future<void> _fetchUserReservations() async {
    try {
      List<Reservation> reservations = await _reservationService
          .fetchUserReservationsFromSharedPreferences();
      setState(() {
        _userReservations = reservations;
      });
    } catch (e) {
      // Handle error
      print('Error fetching user reservations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, top: 10, bottom: 10),
              child: Text("Tickets",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _userReservations.length,
                itemBuilder: (context, index) {
                  Reservation reservation = _userReservations[index];

                  String seatsString = '';
                  for (int i = 0; i < reservation.seats.length; i++) {
                    seatsString += '${reservation.seats[i].id}';
                    if (i != reservation.seats.length - 1) {
                      seatsString +=
                          ', '; // Add a comma and space if it's not the last seat
                    }
                  }

                  String dateString = reservation.show.date; // Example date string: '2024-04-12'
DateTime dateTime = DateTime.parse(dateString);
String formattedDate = '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';

                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      color: Colors.black,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/logo.png",
                            height: 55,
                            width: 55,
                          ),
                          // Text(
                          //   reservation.id.toString(),
                          //   style: TextStyle(
                          //       fontSize: 19,
                          //       fontWeight: FontWeight.w600,
                          //       color: Colors.white),
                          // ),
                          SizedBox(
                            height: 4,
                          ),
                          // Text("Kungfu Panda 4",
                          //     style: TextStyle(
                          //         fontSize: 20,
                          //         fontWeight: FontWeight.w600,
                          //         color: Colors.white)),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    
                                    Text(
                                        "Date: "+formattedDate,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text("Start time: "+reservation.show.start_time,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text("Hall 1",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(widget.pidx ?? '',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                    Text("Seats: " +seatsString,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text("Thank you for your ticket purchase !",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
