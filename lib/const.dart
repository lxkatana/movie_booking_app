class Constants {
  static final String baseUrl = 'http://192.168.1.69:8080/';

  static String loginUrl = baseUrl + 'auth/login';
  static String registerUrl = baseUrl + 'auth/register/user';
  static String registerOtpUrl = baseUrl + 'auth/send-otp';

  static String getAllMovies = baseUrl + 'movie';
  static String getHallByMovies = baseUrl + 'show/movie';

  static String getTakenSeatsByShowId = baseUrl + 'seat/taken';
  static String getHiddenSeatsByHallId = baseUrl + 'seat';
  static String reserveSeats= baseUrl + 'reservation';
  static String paymentSeats= baseUrl + 'payment';
  static String userReservations= baseUrl + 'reservation/bookings';
  static String changePassword = baseUrl + 'user/change-password';
}

