import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.backgroundStart, AppColors.backgroundEnd]),
      ),
      child: const Center(child: Text('Настройки (в разработке)', style: TextStyle(color: AppColors.primaryBlue))),
    );
  }
}