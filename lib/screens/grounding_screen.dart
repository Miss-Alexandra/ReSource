import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class GroundingScreen extends StatefulWidget {
  const GroundingScreen({super.key});

  @override
  State<GroundingScreen> createState() => _GroundingScreenState();
}

class _GroundingScreenState extends State<GroundingScreen> {
  final TextEditingController _sightController = TextEditingController();
  final TextEditingController _touchController = TextEditingController();
  final TextEditingController _hearingController = TextEditingController();
  final TextEditingController _smellController = TextEditingController();
  final TextEditingController _tasteController = TextEditingController();

  @override
  void dispose() {
    _sightController.dispose();
    _touchController.dispose();
    _hearingController.dispose();
    _smellController.dispose();
    _tasteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заземление 5-4-3-2-1'),
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Сосредоточьтесь на своих чувствах, чтобы вернуться в настоящий момент',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    children: [
                      _buildInputField(
                        title: '5 вещей, которые вы видите',
                        controller: _sightController,
                        icon: Icons.visibility,
                      ),
                      const SizedBox(height: 16),
                      _buildInputField(
                        title: '4 вещи, которые вы чувствуете (осязание)',
                        controller: _touchController,
                        icon: Icons.touch_app,
                      ),
                      const SizedBox(height: 16),
                      _buildInputField(
                        title: '3 вещи, которые вы слышите',
                        controller: _hearingController,
                        icon: Icons.audiotrack,
                      ),
                      const SizedBox(height: 16),
                      _buildInputField(
                        title: '2 вещи, которые вы чувствуете запах',
                        controller: _smellController,
                        icon: Icons.air,
                      ),
                      const SizedBox(height: 16),
                      _buildInputField(
                        title: '1 вещь, которую вы можете попробовать',
                        controller: _tasteController,
                        icon: Icons.restaurant,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Здесь можно сохранить записи или просто закрыть
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Запись сохранена'),
                        backgroundColor: AppColors.primaryBlue,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Сохранить',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String title,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primaryBlue, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Введите ответ...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primaryBlue.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primaryBlue.withOpacity(0.3)),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}