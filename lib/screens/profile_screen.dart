import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
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
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primaryBlue,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 12),
              const Text(
                'Александра',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildMenuItem(
                      icon: Icons.edit,
                      title: 'Редактировать профиль',
                      onTap: () => Navigator.pushNamed(context, '/edit_profile'),
                    ),
                    _buildMenuItem(
                      icon: Icons.security,
                      title: 'Безопасность',
                      onTap: () => Navigator.pushNamed(context, '/security'),
                    ),
                    _buildMenuItem(
                      icon: Icons.settings,
                      title: 'Настройки',
                      onTap: () => Navigator.pushNamed(context, '/settings'),
                    ),
                    _buildMenuItem(
                      icon: Icons.help_outline,
                      title: 'Помощь',
                      onTap: () => Navigator.pushNamed(context, '/help'),
                    ),
                    const Divider(),
                    _buildMenuItem(
                      icon: Icons.logout,
                      title: 'Выйти',
                      onTap: () => _showLogoutDialog(context),
                      color: AppColors.emergencyRed,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.primaryBlue),
      title: Text(title, style: TextStyle(color: color ?? AppColors.primaryBlue)),
      trailing: const Icon(Icons.chevron_right, color: AppColors.primaryBlue),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Завершение сеанса'),
        content: const Text('Вы уверены, что хотите выйти из системы?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Оставить'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // Логика выхода
            },
            child: const Text('Да, завершить сеанс'),
          ),
        ],
      ),
    );
  }
}