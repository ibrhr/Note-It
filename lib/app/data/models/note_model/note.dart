import 'package:flutter/material.dart';
import 'package:notes/app/constants/exports.dart';

class Note {
  const Note({required this.text, required this.color, this.image, this.title});
  final String text;
  final String? title;
  final Image? image;
  final Color color;
}
