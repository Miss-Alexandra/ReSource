import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Помощь'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ListTile(
                leading: const Icon(Icons.sync, color: AppColors.primaryBlue),
                title: const Text('Синхронизация между устройствами'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.bug_report, color: AppColors.primaryBlue),
                title: const Text('Сообщить о проблеме'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.contact_support, color: AppColors.primaryBlue),
                title: const Text('Наши контакты'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}