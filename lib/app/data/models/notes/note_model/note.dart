import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes/app/constants/exports.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note {
  const Note({
    this.id,
    required this.title,
    required this.text,
    required this.color,
    this.image,
    required this.date,
    required this.isArchived,
    this.isDeleted = false,
  });

  final int? id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final Image? image;

  @HiveField(4)
  final int? color;

  @HiveField(5)
  final DateTime? date;

  @HiveField(6)
  final bool? isArchived;

  @HiveField(7)
  final bool? isDeleted;
}
