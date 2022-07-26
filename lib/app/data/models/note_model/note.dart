import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes/app/constants/exports.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note {
  const Note({
    this.id,
    this.text,
    this.color,
    this.image,
    this.title,
    this.date,
  });

  final int? id;

  @HiveField(1)
  final String? text;

  @HiveField(2)
  final String? title;

  @HiveField(3)
  final Image? image;

  @HiveField(4)
  final int? color;

  @HiveField(5)
  final DateTime? date;
}
