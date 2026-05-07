import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CalmingAudioScreen extends StatelessWidget {
  const CalmingAudioScreen({super.key});

  // Пример списка аудио (можно заменить на реальные файлы)
  final List<Map<String, String>> audioList = const [
    {'title': 'Шум дождя', 'duration': '10:23'},
    {'title': 'Океанские волны', 'duration': '8:45'},
    {'title': 'Лесные звуки', 'duration': '12:07'},
    {'title': 'Белый шум', 'duration': '15:00'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Успокаивающее аудио'),
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
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: audioList.length,
            itemBuilder: (context, index) {
              final audio = audioList[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  leading: const Icon(Icons.play_circle_fill, color: AppColors.primaryBlue, size: 36),
                  title: Text(audio['title']!, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                  subtitle: Text(audio['duration']!, style: const TextStyle(color: AppColors.primaryBlue)),
                  trailing: const Icon(Icons.more_vert, color: AppColors.primaryBlue),
                  onTap: () {
                    // Здесь будет воспроизведение аудио
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Воспроизведение "${audio['title']}"')),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}