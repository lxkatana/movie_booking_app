import 'package:flutter/material.dart';
import 'package:movie_booking/model/reservation_model.dart';
import 'package:movie_booking/services/reservation_services.dart';
import 'package:movie_booking/views/screens/home.dart';

class Booking extends StatefulWidget {
  Booking({this.pidx, super.key});
  final String? pidx;

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final ReservationService _reservationService = ReservationService();
  late List<Reservation> _userReservations;

  @override
  void initState() {
    super.initState();
    _userReservations = []; // Initialize the reservations list
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
      print('Error fetching user reservations: $e');
      // Handle error here
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
              child: Text(
                "Tickets",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _userReservations.length,
                itemBuilder: (context, index) {
                  Reservation reservation = _userReservations[index];

                  // Logic to format seats string
                  String seatsString =
                      reservation.seats!.map((seat) => seat.seatNo).join(', ');

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
                          SizedBox(
                            height: 4,
                          ),
                          Text(reservation.show!.movie!.title.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                          SizedBox(
                            height: 4,
                          ),
                          Text(reservation.show!.cinema!.name.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date: ${reservation.show?.date}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "Start time: ${reservation.show?.startTime} ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        reservation.show!.hall!.name.toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Seats: $seatsString",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        widget.pidx ?? '',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text(
                              "Thank you for your ticket purchase !",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
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
