import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants/app_colors.dart';
import '../widgets/mood_indicator_painter.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int _moodValue = 4;
  final List<String> _moodEmojis = const ['😢', '😔', '😐', '😊', '😃'];

  double get _progress => (_moodValue - 1) / 4;

  String _getCurrentDate() {
    final now = DateTime.now();
    const months = [
      'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
      'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'
    ];
    const weekdays = [
      'понедельник', 'вторник', 'среда', 'четверг', 'пятница', 'суббота', 'воскресенье'
    ];
    return '${now.day} ${months[now.month - 1]} ${now.year}\n${weekdays[now.weekday - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _getCurrentDate(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/search'),
                          child: const CircleAvatar(
                            backgroundColor: Colors.white30,
                            child: Icon(Icons.search, color: AppColors.primaryBlue),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      'Как вы себя чувствуете?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: CustomPaint(
                        painter: MoodIndicatorPainter(
                          progress: _progress,
                          ringColor: Colors.white,
                          ringStrokeWidth: 10,
                        ),
                        child: Center(
                          child: Text(
                            _moodValue.toString(),
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(_moodEmojis.length, (index) {
                      final isSelected = _moodValue == index + 1;
                      return GestureDetector(
                        onTap: () => setState(() => _moodValue = index + 1),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white.withOpacity(0.5)
                                : Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: AppColors.primaryBlue, width: 2)
                                : null,
                          ),
                          child: Text(
                            _moodEmojis[index],
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/emergency'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.emergencyRed,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: AppColors.emergencyRed,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Экстренная помощь',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Тенденции настроения',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 120,
                          child: LineChart(
                            LineChartData(
                              lineBarsData: [
                                LineChartBarData(
                                  spots: const [
                                    FlSpot(0, 3),
                                    FlSpot(1, 4),
                                    FlSpot(2, 2),
                                    FlSpot(3, 5),
                                    FlSpot(4, 3),
                                    FlSpot(5, 4),
                                    FlSpot(6, 4),
                                  ],
                                  isCurved: true,
                                  color: AppColors.primaryBlue,
                                  barWidth: 3,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: AppColors.primaryBlue.withOpacity(0.2),
                                  ),
                                ),
                              ],
                              titlesData: const FlTitlesData(show: false),
                              gridData: const FlGridData(show: false),
                              borderData: FlBorderData(show: false),
                              minY: 0,
                              maxY: 5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}