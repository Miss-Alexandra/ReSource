import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Экстренная помощь'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildOption(
              context,
              icon: Icons.air,
              title: 'Дыхательное упражнение',
              description: 'Техника 4-7-8 для успокоения',
              onTap: () => Navigator.pushNamed(context, '/breathing'),
            ),
            const SizedBox(height: 16),
            _buildOption(
              context,
              icon: Icons.touch_app,
              title: 'Заземление 5-4-3-2-1',
              description: 'Сосредоточьтесь на своих чувствах',
              onTap: () => Navigator.pushNamed(context, '/grounding'),
            ),
            const SizedBox(height: 16),
            _buildOption(
              context,
              icon: Icons.photo_library,
              title: 'Фотографии-ресурсы',
              description: 'Просмотрите установленные изображения',
              onTap: () => _showPlaceholder(context, 'Фотографии-ресурсы'),
            ),
            const SizedBox(height: 16),
            _buildOption(
              context,
              icon: Icons.audiotrack,
              title: 'Успокаивающее аудио',
              description: 'Слушайте установленные звуки',
              onTap: () => _showPlaceholder(context, 'Успокаивающее аудио'),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            _buildHotlineButton(
              context,
              title: 'Телефон доверия',
              number: '8-800-2000-122',
              onTap: () => _callNumber(context, '88002000122'),
            ),
            const SizedBox(height: 12),
            _buildHotlineButton(
              context,
              title: 'Экстренные службы',
              number: '112',
              onTap: () => _callNumber(context, '112'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context,
      {required IconData icon, required String title, required String description, required VoidCallback onTap}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryBlue.withOpacity(0.2),
          child: Icon(icon, color: AppColors.primaryBlue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
        subtitle: Text(description, style: const TextStyle(color: AppColors.primaryBlue)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.primaryBlue),
        onTap: onTap,
      ),
    );
  }

  Widget _buildHotlineButton(BuildContext context,
      {required String title, required String number, required VoidCallback onTap}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryBlue.withOpacity(0.2),
          child: const Icon(Icons.phone, color: AppColors.primaryBlue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
        subtitle: Text(number, style: const TextStyle(color: AppColors.primaryBlue)),
        trailing: const Icon(Icons.call, color: AppColors.primaryBlue),
        onTap: onTap,
      ),
    );
  }

  void _showPlaceholder(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: const Text('Функция в разработке'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  void _callNumber(BuildContext context, String number) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Вызов'),
        content: Text('Номер: $number'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Вызов на номер $number (имитация)')),
              );
            },
            child: const Text('Позвонить'),
          ),
        ],
      ),
    );
  }
}