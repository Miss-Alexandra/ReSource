import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ResourcePhotosScreen extends StatelessWidget {
  const ResourcePhotosScreen({super.key});

  // Замените на реальные пути к изображениям в assets
  final List<String> imagePaths = const [
    'assets/photos/photo1.jpg',
    'assets/photos/photo2.jpg',
    'assets/photos/photo3.jpg',
    'assets/photos/photo4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Фотографии-ресурсы'),
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
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePaths[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.primaryBlue.withOpacity(0.1),
                    child: const Icon(Icons.broken_image, color: AppColors.primaryBlue),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}