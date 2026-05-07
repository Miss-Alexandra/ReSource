import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkTheme = false;
  bool deleteData = false;
  bool allNotifications = true;
  bool autoTime = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
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
            padding: const EdgeInsets.all(16),
            children: [
              SwitchListTile(
                title: const Text('Включить тёмную тему', style: TextStyle(color: AppColors.primaryBlue)),
                value: darkTheme,
                activeColor: AppColors.primaryBlue,
                onChanged: (v) => setState(() => darkTheme = v),
              ),
              SwitchListTile(
                title: const Text('Удаление данных', style: TextStyle(color: AppColors.primaryBlue)),
                value: deleteData,
                activeColor: AppColors.primaryBlue,
                onChanged: (v) => setState(() => deleteData = v),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Уведомления', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
              ),
              SwitchListTile(
                title: const Text('Все уведомления', style: TextStyle(color: AppColors.primaryBlue)),
                value: allNotifications,
                activeColor: AppColors.primaryBlue,
                onChanged: (v) => setState(() => allNotifications = v),
              ),
              SwitchListTile(
                title: const Text('Время автоматическое', style: TextStyle(color: AppColors.primaryBlue)),
                value: autoTime,
                activeColor: AppColors.primaryBlue,
                onChanged: (v) => setState(() => autoTime = v),
              ),
              const Divider(),
              ListTile(
                title: const Text('Сменить PIN-код', style: TextStyle(color: AppColors.primaryBlue)),
                trailing: const Icon(Icons.chevron_right, color: AppColors.primaryBlue),
                onTap: () {
                  // Открыть диалог смены PIN (можно использовать тот же, что в SecurityScreen)
                },
              ),
              ListTile(
                title: const Text('Удалить аккаунт', style: TextStyle(color: AppColors.emergencyRed)),
                trailing: const Icon(Icons.delete, color: AppColors.emergencyRed),
                onTap: () {
                  // Открыть диалог удаления
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}