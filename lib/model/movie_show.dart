import 'movie.dart'; // Import your existing Movie model

class Cinema {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String password;
  final String salt;
  final String email;
  final String address;

  Cinema({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.password,
    required this.salt,
    required this.email,
    required this.address,
  });

  factory Cinema.fromJson(Map<String, dynamic> json) {
    return Cinema(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      name: json['name'],
      password: json['password'],
      salt: json['salt'],
      email: json['email'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'name': name,
      'password': password,
      'salt': salt,
      'email': email,
      'address': address,
    };
  }
}

class Hall {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final DateTime? deletedDate;

  Hall({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.deletedDate,
  });

  factory Hall.fromJson(Map<String, dynamic> json) {
    return Hall(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      name: json['name'],
      deletedDate: json['deletedDate'] != null
          ? DateTime.parse(json['deletedDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'name': name,
      'deletedDate': deletedDate?.toIso8601String(),
    };
  }
}

class MovieShow {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime date;
  final String startTime;
  final Cinema cinema;
  final Hall hall;
  final Movie movie; // Reference your existing Movie model here

  MovieShow({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    required this.startTime,
    required this.cinema,
    required this.hall,
    required this.movie,
  });

  factory MovieShow.fromJson(Map<String, dynamic> json) {
    return MovieShow(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      date: DateTime.parse(json['date']),
      startTime: json['start_time'],
      cinema: Cinema.fromJson(json['cinema']),
      hall: Hall.fromJson(json['hall']),
      movie: Movie.fromJson(json['movie']), // Parse using your existing Movie.fromJson method
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'date': date.toIso8601String(),
      'start_time': startTime,
      'cinema': cinema.toJson(),
      'hall': hall.toJson(),
      'movie': movie.toJson(),
    };
  }
}
