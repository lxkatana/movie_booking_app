class Customer {
  final String? name;

  Customer({
    this.name,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      name: json['name'],
    );
  }
}

class Seat {
  final int? id;
  final Map<String, dynamic>? seatData;

  Seat({
    required this.id,
    required this.seatData,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    final seatJson = json['seat'] as Map<String, dynamic>?;
    return Seat(
      id: json['id'],
      seatData: seatJson,
    );
  }

  String? get seatNo => seatData?['seat_no'];
}

class Hall {
  final String? name;

  Hall({
    this.name,
  });

  factory Hall.fromJson(Map<String, dynamic> json) {
    return Hall(
      name: json['name'],
    );
  }
}

class Cinema {
  final String? name;

  Cinema({
    this.name,
  });

  factory Cinema.fromJson(Map<String, dynamic> json) {
    return Cinema(
      name: json['name'],
    );
  }
}

class Movie {
  final String? title;

  Movie({
    this.title,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
    );
  }
}

class Show {
  final String? date;
  final int? price;
  final String? startTime;
  final List<Reservation>? reservations;
  final Hall? hall;
  final Movie? movie;
  final Cinema? cinema;

  Show({
    required this.date,
    required this.price,
    required this.startTime,
    required this.reservations,
    required this.hall,
    required this.movie,
    required this.cinema,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      date: json['date'],
      price: json['price'],
      startTime: json['start_time'],
      reservations: (json['reservations'] as List<dynamic>?)
          ?.map((reservationJson) => Reservation.fromJson(reservationJson))
          .toList(),
      hall: json['hall'] != null ? Hall.fromJson(json['hall']) : null,
      movie: json['movie'] != null ? Movie.fromJson(json['movie']) : null,
      cinema: json['cinema'] != null ? Cinema.fromJson(json['cinema']) : null,
    );
  }
}

class Reservation {
  final String? createdAt;
  final String? status;
  final Customer? customer;
  final List<Seat>? seats;
  final Show? show;
  final String? payment;

  Reservation({
    required this.createdAt,
    required this.status,
    required this.customer,
    required this.seats,
    required this.show,
    this.payment,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      createdAt: json['createdAt'],
      status: json['status'],
      customer: json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      seats: (json['seats'] as List<dynamic>?)
          ?.map((seatJson) => Seat.fromJson(seatJson))
          .toList(),
      show: json['show'] != null ? Show.fromJson(json['show']) : null,
      payment: json['payment'],
    );
  }
}
