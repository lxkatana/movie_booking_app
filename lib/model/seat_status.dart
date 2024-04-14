import 'package:flutter/material.dart';

class SeatStatus {
  final int id;
  final String seatNo;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool isBooked;
  bool isReserved;

  SeatStatus({
    required this.id,
    required this.seatNo,
    required this.createdAt,
    required this.updatedAt,
    this.isBooked = false, // Initialize with default values
    this.isReserved = false,
  });

  factory SeatStatus.fromJson(Map<String, dynamic> json) {
    return SeatStatus(
      id: json['id'],
      seatNo: json['seat_no'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

