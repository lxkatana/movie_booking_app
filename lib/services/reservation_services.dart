import 'package:http/http.dart' as http;
import 'package:movie_booking/const.dart';
import 'package:movie_booking/model/reservation_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ReservationService {
  Future<List<Reservation>> fetchUserReservationsFromSharedPreferences() async {
    try {
      // Fetch authentication token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? authToken = prefs.getString('token');

      if (authToken == null) {
        throw Exception('Authentication token not found in SharedPreferences');
      }

      // Make API call with fetched authentication token
      final response = await http.get(
        Uri.parse(Constants.userReservations),
        headers: {'Authorization': 'Bearer $authToken'},
      );
      print("Token: " + authToken.toString());
      final dynamic jsonData = json.decode(response.body);
      if (jsonData == null || !(jsonData is Map<String, dynamic>)) {
        throw Exception('Invalid data received from the server');
      }

      final List<dynamic> reservationData = jsonData['data'];
      print(reservationData);
      if (reservationData == null) {
        return [];
      } else {
        return (reservationData)
            .map((json) => Reservation.fromJson(json))
            .toList();
      }
    } catch (e) {
      throw Exception('Here Failed to load user reservations: $e');
    }
  }
}
