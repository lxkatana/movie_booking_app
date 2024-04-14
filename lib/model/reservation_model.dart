class Customer {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String name;
  final String password;
  final String salt;
  final String email;
  final String phone;

  Customer({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.password,
    required this.salt,
    required this.email,
    required this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      name: json['name'],
      password: json['password'],
      salt: json['salt'],
      email: json['email'],
      phone: json['phone'],
    );
  }
}

class Seat {
  final int id;
  final String createdAt;
  final String updatedAt;
  final dynamic seat; // Assuming seat is a complex object, you can change its type accordingly

  Seat({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.seat,
    
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      seat: json['seat'], // Assuming seat is a complex object, you can change its type accordingly
    );
  }
}

class Show {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String date;
  final int price;
  final String start_time;
  final bool isActive;
  final dynamic deleteAt; // Assuming deleteAt can be null, you can change its type accordingly

  Show({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    required this.price,
    required this.start_time,
    required this.isActive,
    required this.deleteAt,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      date: json['date'],
      price: json['price'],
      start_time: json['start_time'],
      isActive: json['isActive'],
      deleteAt: json['deleteAt'],
    );
  }
}

class Payment {
  // Define your Payment model attributes here
}

class Reservation {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String status;
  final Customer customer;
  final List<Seat> seats;
  final Show show;
  final Payment? payment; // Make payment nullable

  Reservation({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.customer,
    required this.seats,
    required this.show,
    this.payment, // Nullable payment
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      status: json['status'],
      customer: Customer.fromJson(json['customer']),
      seats: (json['seats'] as List<dynamic>).map((seatJson) => Seat.fromJson(seatJson)).toList(),
      show: Show.fromJson(json['show']),
      // payment: json['payment'] != null ? Payment.fromJson(json['payment']) : null, // Parse payment if not null
    );
  }
}
