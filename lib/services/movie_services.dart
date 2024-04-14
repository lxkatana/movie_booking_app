import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_booking/const.dart';
import 'package:movie_booking/model/movie.dart';
import 'package:movie_booking/model/movie_show.dart';

class MovieService {
  static String baseUrl = Constants.getAllMovies;

  static Future<Movie> fetchMovieInfo(int movieId) async {
    final response = await http.get(Uri.parse('$baseUrl/$movieId'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'];
      return Movie.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch movie details');
    }
  }

  static Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse(Constants.getAllMovies));
    print("Services movies *");
    if (response.statusCode == 200) {
      print("Response code 200 on services !");
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      return jsonData.map((json) => Movie.fromJson(json)).toList();
    } else {
      print("Failed to fetch movies");
      throw Exception('Failed to fetch movies');
    }
  }

  List<MovieShow> parseMovieShows(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<MovieShow>((json) => MovieShow.fromJson(json)).toList();
  }

  static Future<List<MovieShow>> fetchMovieShowsByMovieId(int movieId) async {
    final response = await http.get(Uri.parse(Constants.getHallByMovies+ '/$movieId'));
    if (response.statusCode == 200) {
      
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      return jsonData.map((json) => MovieShow.fromJson(json)).toList();
    } else {
      print("Failed to load shows data");
      throw Exception('Failed to fetch movie shows');
    }
  }
}
