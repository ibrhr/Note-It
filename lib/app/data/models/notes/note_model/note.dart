import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note {
  const Note({
    this.id,
    required this.title,
    required this.text,
    required this.color,
    this.images = const <String>[],
    required this.date,
     this.isArchived = false,
    this.isDeleted = false,
  });

  final int? id;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final List<String> images;

  @HiveField(4)
  final int? color;

  @HiveField(5)
  final DateTime date;

  @HiveField(6)
  final bool? isArchived;

  @HiveField(7)
  final bool? isDeleted;
}
