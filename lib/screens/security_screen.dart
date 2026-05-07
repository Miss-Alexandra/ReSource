import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Безопасность'),
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
                title: const Text('Сменить PIN-код'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showChangePinDialog(context),
              ),
              const Divider(),
              ListTile(
                title: const Text('Условия и положения'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showTermsDialog(context),
              ),
              ListTile(
                title: const Text('Политика конфиденциальности'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showPrivacyDialog(context),
              ),
              const Divider(),
              ListTile(
                title: const Text('Удалить аккаунт', style: TextStyle(color: AppColors.emergencyRed)),
                trailing: const Icon(Icons.delete, color: AppColors.emergencyRed),
                onTap: () => _showDeleteAccountDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showChangePinDialog(BuildContext context) {
    final currentPinController = TextEditingController();
    final newPinController = TextEditingController();
    final confirmPinController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Сменить PIN-код'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPinController,
              decoration: const InputDecoration(labelText: 'Текущий PIN-код'),
              obscureText: true,
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: newPinController,
              decoration: const InputDecoration(labelText: 'Новый PIN-код'),
              obscureText: true,
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: confirmPinController,
              decoration: const InputDecoration(labelText: 'Подтвердите PIN-код'),
              obscureText: true,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Отмена')),
          ElevatedButton(
            onPressed: () {
              if (newPinController.text == confirmPinController.text && newPinController.text.isNotEmpty) {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('PIN-код успешно изменён')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('PIN-коды не совпадают или пусты')),
                );
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Условия использования'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1. Посещение Просвещения в Интернете.'),
              Text('2. Использование через браузер.'),
              Text('3. Использование мобильного приложения.'),
              Text('4. Установка из официальных магазинов.'),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Закрыть')),
        ],
      ),
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Политика конфиденциальности'),
        content: const Text('Ваши данные защищены...'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Закрыть')),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final pinController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить аккаунт'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Вы уверены, что хотите удалить свою учетную запись?'),
            const SizedBox(height: 16),
            const Text('Это действие приведет к необратимому удалению всех ваших данных.'),
            const SizedBox(height: 16),
            TextField(
              controller: pinController,
              decoration: const InputDecoration(labelText: 'Введите PIN-код для подтверждения'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Отмена')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.emergencyRed),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Аккаунт удалён (имитация)')),
              );
            },
            child: const Text('Удалить аккаунт'),
          ),
        ],
      ),
    );
  }
}