import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category{
  travel, food, leisure, work
}
const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
  Category.leisure: Icons.movie,
};

class Expense{
  Expense({required this.title, required this.amount, required this.date, required this.category}) : id = uuid.v4();

  final String id;
  final String title;
  final String amount;
  final DateTime date;
  final Category category;

  String get dateFormatted{
     return formatter.format(date);
  }
}
