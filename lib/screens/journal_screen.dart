import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.backgroundStart, AppColors.backgroundEnd]),
      ),
      child: const Center(child: Text('Дневник (в разработке)', style: TextStyle(color: AppColors.primaryBlue))),
    );
  }
}