import 'package:http/http.dart' as http;
import 'package:movie_booking/model/reservation_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ReservationService {
  Future<List<Reservation>> fetchUserReservationsFromSharedPreferences() async {
    try {
      // Fetch authentication token from SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token'); // Change 'token' to match your key in SharedPreferences
print("Token: "+ token.toString());
      if (token == null) {
        throw Exception('Token not found in SharedPreferences');
      }

      // Make API call with fetched authentication token
      final response = await http.get(
        Uri.parse('http://192.168.1.69:8080/reservation/bookings'), // Update the URL to your API endpoint
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        print("200");
        final dynamic jsonData = json.decode(response.body);
        if (jsonData is Map<String, dynamic> && jsonData.containsKey('data')) {
        print("- 200");
          final List<dynamic> reservationData = jsonData['data'];
          print("-- 200");
          return reservationData.map((json) => Reservation.fromJson(json)).toList();
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Failed to load user reservations');
      }
    } catch (e) {
      throw Exception('Failed to load user reservations: $e');
    }
  }
}
