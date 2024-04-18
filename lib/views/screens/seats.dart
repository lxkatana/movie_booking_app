import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:movie_booking/model/movie_show.dart';
import 'package:movie_booking/const.dart';
import 'package:movie_booking/views/screens/booking.dart';

import 'package:shared_preferences/shared_preferences.dart';

class BookingStatus {
  int seatId;
  String seatNumber;
  String seatName;
  bool isBooked;
  bool isReserved;

  BookingStatus(this.seatId, this.seatNumber, this.seatName, this.isBooked,
      this.isReserved);
}

class MovieSeats extends StatefulWidget {
  final MovieShow movieShow;

  const MovieSeats({Key? key, required this.movieShow}) : super(key: key);

  @override
  State<MovieSeats> createState() => _MovieSeatsState();
}

class _MovieSeatsState extends State<MovieSeats> {
  String pidx = '';
  late List<BookingStatus> seatStatus;
  List<BookingStatus> selectedSeats = [];
  double seatPrice = 0; // Set the price for one seat here

  List<Map<String, dynamic>> hiddenSeatNumbers = [];

  List<String> reservedSeatNumbers =
      []; // Reserved seat numbers fetched from URL

  @override
  void initState() {
    super.initState();
    setState(() {
      seatPrice = widget.movieShow.price.toDouble();
    });
    _initializeSeats();
    _fetchHiddenSeats();
    _fetchReservedSeats();
    getTokenFromSharedPreferences();
  }

  void _initializeSeats() {
    const int totalRows = 10;
    const int seatsPerRow = 10;
    const List<String> alphabet = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J'
    ];

    seatStatus = [];
    for (int row = 0; row < totalRows; row++) {
      for (int col = 0; col < seatsPerRow; col++) {
        String seatNumber = '${alphabet[row]}${col + 1}';
        String seatName = 'Seat $seatNumber';
        bool isReserved = reservedSeatNumbers.contains(seatNumber);

        // Check if the seat is hidden and get its ID
        var hiddenSeat = hiddenSeatNumbers.firstWhere(
            (seat) => seat['seatNumber'] == seatNumber,
            orElse: () => {'id': '-1'});
        String seatId = hiddenSeat['id']; // Use 'id' from the hidden seat map

        seatStatus.add(BookingStatus(
            int.parse(seatId), seatNumber, seatName, false, isReserved));
      }
    }
  }

  void _fetchHiddenSeats() async {
    final response = await http.get(Uri.parse(
        Constants.getHiddenSeatsByHallId + '/${widget.movieShow.hall.id}'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> hiddenSeatsData = jsonData['data'];

      hiddenSeatNumbers.clear();
      for (var hiddenSeat in hiddenSeatsData) {
        String seatNumber = hiddenSeat['seat_no'];
        String seatId = hiddenSeat['id'].toString(); // Convert id to string
        hiddenSeatNumbers.add({
          'seatNumber': seatNumber,
          'id': seatId
        }); // Add map containing seatNumber and id
      }

      setState(() {
        _initializeSeats();
      });
    } else {
      throw Exception('Failed to fetch hidden seats');
    }
  }

  Future<void> _fetchReservedSeats() async {
    print("Show Id: " + widget.movieShow.id.toString());
    final response = await http.get(
        Uri.parse(Constants.getTakenSeatsByShowId + '/${widget.movieShow.id}'));

    if (response.statusCode == 200) {
      print("Response code 200");
      final jsonData = json.decode(response.body);
      final List<dynamic> reservedSeatsData = jsonData['data'];

      reservedSeatNumbers.clear();
      for (var reservedSeat in reservedSeatsData) {
        print("Seat No: " +
            reservedSeat['seat']['seat_no'] +
            " Id: " +
            reservedSeat['seat']['id'].toString());
        String seatId = reservedSeat['seat']['seat_no'].toString();

        reservedSeatNumbers.add(seatId);
      }

      setState(() {
        _initializeSeats();
      });
    } else {
      print("Failed to fetch the seats");
      throw Exception('Failed to fetch reserved seats');
    }
  }

  static Future<String?> getTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void _toggleSeatSelection(BookingStatus seat) {
    // If the seat is reserved, do not allow selection
    if (seat.isReserved) return;

    setState(() {
      if (seat.isBooked) {
        // If the seat is already booked, unbook it and remove it from selected seats
        seat.isBooked = false;
        selectedSeats.remove(seat);
      } else {
        // If the seat is available, mark it as booked, add it to selected seats
        seat.isBooked = true;
        selectedSeats.add(seat);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 26.0, right: 26.0, top: 18, bottom: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movieShow.movie.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.movieShow.cinema.name +
                          " | " +
                          widget.movieShow.hall.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${widget.movieShow.date} | ${widget.movieShow.startTime}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 16, bottom: 16),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10,
                      ),
                      itemCount: seatStatus.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final seat = seatStatus[index];
                        Color seatColor;
          
                        if (reservedSeatNumbers
                            .contains(seat.seatNumber.toString())) {
                          // If the seat ID is in the reservedSeatNumbers list, set color to red
                          seatColor = Colors.red;
                        } else if (hiddenSeatNumbers.any((hiddenSeat) =>
                            hiddenSeat['id'] == seat.seatId.toString())) {
                          // If the seat is hidden, set the color to blur color (e.g., blue)
                          seatColor = Colors.blue;
                          if (selectedSeats.contains(seat) && !seat.isReserved) {
                            // If the seat is selected and not reserved, change its color to green
                            seatColor = Colors.green;
                          }
                        } else {
                          // If the seat is not reserved or hidden, set the color to transparent
                          seatColor = Colors.white;
                        }
          
                        return Padding(
                          padding: const EdgeInsets.all(2),
                          child: GestureDetector(
                            onTap: () {
                              // Check if the seat is not reserved before toggling selection
                              if (!seat.isReserved) {
                                _toggleSeatSelection(seat);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: seatColor,
                              ),
                              height: 20,
                              width: 20,
                              child: Center(
                                child: Text(
                                  seat.seatNumber,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 18,
                                color: Colors.blue,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text("Available"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 18,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text("Reserved"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 18,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text("Selected"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'No. of Seats Booked: ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '${selectedSeats.length}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Total Price: \$',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '${selectedSeats.length * seatPrice}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: payWithKhaltiInApp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black87,
                              ),
                              child: const Text(
                                'Book Seats',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.white),
                              ),
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
      ),
    );
  }

  payWithKhaltiInApp() {
    KhaltiScope.of(context).pay(
        config: PaymentConfig(
          amount: 1000,
          productIdentity: 'dell-g5-g5510-2021',
          productName: 'Dell G5 G5510 2021',
          productUrl: 'https://www.khalti.com/#/bazaar',
        ),
        preferences: [PaymentPreference.khalti],
        onSuccess: onSuccess,
        onFailure: onFailure,
        onCancel: onCancel);
  }

  void onSuccess(PaymentSuccessModel success) {
    pidx = success.idx;
    _bookSeats(pidx);
    _seatPayment(pidx);
  }

  void onFailure(PaymentFailureModel failure) {
    print("Payment Failed");
    debugPrint(failure.toString());
  }

  void onCancel() {
    print("Cancled Payment");
    debugPrint("Cancled Payment");
  }

  Future<void> _bookSeats(String pidx) async {
    // Obtain the authentication token from shared preferences
    String? token = await getTokenFromSharedPreferences();

    print("Token: ${token}");
    if (token == null) {
      // Token is not available, handle this case (e.g., show an error message)
      print('Authentication token is not available');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication token is not available')),
      );
      return; // Exit the method
    }

    // Prepare the payload for the reservation request
    Map<String, dynamic> payload = {
      'status': 'reserved',
      'seats': selectedSeats.map((seat) => seat.seatId).toList(),
    };

    // Convert the payload to JSON
    String payloadJson = json.encode(payload);

    try {
      // Define the headers for the request
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Include the auth token here
      };

      // Make the reservation request
      final response = await http.post(
        Uri.parse(Constants.reserveSeats + '/${widget.movieShow.id}'),
        headers: headers,
        body: payloadJson,
      );
      print(response.body);

      if (response.statusCode == 200) {
        print("Seats reserved successfully");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Seats reserved successfully')),
        // );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Booking(pidx: pidx)),
        );
      } else {
        // Reservation failed
        // Show an error message or handle the failure appropriately
        print('Failed to reserve seats: ${response.statusCode}');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Failed to reserve seats: ${response.statusCode}'),
        //   ),
        // );
      }
    } catch (e) {
      // Handle any errors that occur during the reservation request
      print('Error reserving seats: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error reserving seats: $e')),
      );
    }
  }

  Future<void> _seatPayment(String pidx) async {
    // Obtain the authentication token from shared preferences
    String? token = await getTokenFromSharedPreferences();

    print("Token: ${token}");
    if (token == null) {
      // Token is not available, handle this case (e.g., show an error message)
      print('Authentication token is not available');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication token is not available')),
      );
      return; // Exit the method
    }

    // Prepare the payload for the reservation request
    Map<String, dynamic> payload = {
      'seats': selectedSeats.map((seat) => seat.seatId).toList(),
      'amountInRs': widget.movieShow.price,
      'pidx': pidx,
    };

    // Convert the payload to JSON
    String payloadJson = json.encode(payload);

    try {
      // Define the headers for the request
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Include the auth token here
      };

      // Make the reservation request
      final response = await http.post(
        Uri.parse(Constants.paymentSeats + '/${widget.movieShow.id}'),
        headers: headers,
        body: payloadJson,
      );
      print("Payment Data: " + response.body);

      if (response.statusCode == 200) {
        print("Seats payment successfull");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Seats payment successfull')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Booking(pidx: pidx)),
        );
      } else {
        // Reservation failed
        // Show an error message or handle the failure appropriately
        print('Failed to reserve seats for payment: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to reserve seats: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the reservation request
      print('Error reserving seats: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error reserving seats: $e')),
      );
    }
  }
}
