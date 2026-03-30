import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants/app_colors.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  final List<Map<String, String>> days = const [
    {'day': '23', 'label': 'м'}, {'day': '24', 'label': 'сб'}, {'day': '25', 'label': 'вс'},
    {'day': '26', 'label': 'пн'}, {'day': '27', 'label': 'вт'}, {'day': '28', 'label': 'ср'},
    {'day': '29', 'label': 'пт', 'today': 'сегодня'},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [AppColors.backgroundStart, AppColors.backgroundEnd]),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text('29 окт., 2026', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.primaryBlue)),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(color: Color(0xFFFFF8E1), shape: BoxShape.circle),
                          child: const Icon(Icons.local_fire_department, color: Colors.orange, size: 20),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('1-дневная полоса', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                              Text('Маленькие шаги, большие победы!', style: TextStyle(fontSize: 14, color: AppColors.primaryBlue)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: days.map((day) {
                      final isToday = day.containsKey('today');
                      return Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isToday ? AppColors.primaryBlue : Colors.white,
                              border: Border.all(color: isToday ? AppColors.primaryBlue : AppColors.primaryBlue.withOpacity(0.5), width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                day['day']!,
                                style: TextStyle(
                                  color: isToday ? Colors.white : AppColors.primaryBlue,
                                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            day['label']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: isToday ? AppColors.primaryBlue : AppColors.primaryBlue.withOpacity(0.7),
                            ),
                          ),
                          if (isToday) ...[
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(color: AppColors.primaryBlue.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                              child: const Text(
                                'сегодня',
                                style: TextStyle(fontSize: 8, color: AppColors.primaryBlue, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 28),
                  const Center(child: Text('2026', style: TextStyle(fontSize: 14, color: AppColors.primaryBlue, fontWeight: FontWeight.w600))),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 4)),
                    ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Тенденции настроения', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryBlue)),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 150,
                          child: LineChart(LineChartData(
                            lineBarsData: [
                              LineChartBarData(
                                spots: const [FlSpot(0, 3), FlSpot(1, 4), FlSpot(2, 2), FlSpot(3, 5), FlSpot(4, 3), FlSpot(5, 4), FlSpot(6, 4)],
                                isCurved: true,
                                color: AppColors.primaryBlue,
                                barWidth: 3,
                                belowBarData: BarAreaData(show: true, color: AppColors.primaryBlue.withOpacity(0.2)),
                              ),
                            ],
                            titlesData: const FlTitlesData(show: false),
                            gridData: const FlGridData(show: false),
                            borderData: FlBorderData(show: false),
                            minY: 0,
                            maxY: 5,
                          )),
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