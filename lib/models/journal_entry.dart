import 'package:flutter/material.dart';

enum EntryType { free, pillars }

class JournalEntry {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final TimeOfDay? time;
  final EntryType type;
  final List<String> tags;
  final String? audioPath;
  final List<String>? imagePaths;
  // Поля для столпов устойчивости
  final String? safety;
  final String? connection;
  final String? calm;
  final String? effectiveness;
  final String? hope;

  JournalEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    this.time,
    required this.type,
    this.tags = const [],
    this.audioPath,
    this.imagePaths,
    this.safety,
    this.connection,
    this.calm,
    this.effectiveness,
    this.hope,
  });
}