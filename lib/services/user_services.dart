import 'package:http/http.dart' as http;
import 'package:movie_booking/const.dart';
import 'package:movie_booking/model/user_model.dart';
import 'dart:convert';

class UserService {
  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.baseUrl + Constants.loginUrl),
        body: json.encode(
            {'email': email, 'password': password, 'validateFor': 'customer'}),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error logging in: $e');
      // Handle error
      return false;
    }
  }

  static Future<bool> sendOTP(String email) async {
    final mainUrl = Constants.baseUrl + Constants.registerOtpUrl;
    print("Main URL: " + mainUrl);
    print("base URL: " + Constants.baseUrl);
    print("registerOtp URL: " + Constants.registerOtpUrl);
    try {
      final response = await http.post(
        Uri.parse(mainUrl),
        body: {'email': email, 'purpose': 'signupCustomer'},
      );

      if (response.statusCode == 200) {
        print('OTP sent successfully');
        return true;
      } else {
        print('Failed to send OTP');
        return false;
      }
    } catch (e) {
      print('Error sending OTP: $e');
      return false;
    }
  }

  static Future<bool> registerUser(User user, String otp) async {
    try {
      final response = await http.post(
        Uri.parse(Constants.baseUrl + Constants.registerUrl),
        body: jsonEncode({
          'name': user.name,
          'email': user.email,
          'password': user.password,
          'phone': user.phone,
          'otp': otp
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Registration successful
        return true;
      } else {
        // Registration failed
        return false;
      }
    } catch (e) {
      print('Error registering user: $e');
      throw Exception('Failed to register user');
    }
  }
}
