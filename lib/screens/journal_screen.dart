import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/journal_entry.dart';

class JournalScreen extends StatelessWidget {
  final List<JournalEntry> entries;

  const JournalScreen({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const TabBar(
                labelColor: AppColors.primaryBlue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.primaryBlue,
                tabs: [
                  Tab(text: 'Свободная форма'),
                  Tab(text: 'Столпы устойчивости'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildEntryList(EntryType.free),
                    _buildEntryList(EntryType.pillars),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEntryList(EntryType type) {
    final filtered = entries.where((e) => e.type == type).toList();
    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              type == EntryType.free ? Icons.edit_note : Icons.self_improvement,
              size: 64,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(height: 16),
            const Text(
              'Пока нет записей',
              style: TextStyle(fontSize: 18, color: AppColors.primaryBlue),
            ),
            const SizedBox(height: 8),
            Text(
              'Нажмите "+" для создания',
              style: TextStyle(color: AppColors.primaryBlue.withOpacity(0.7)),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final entry = filtered[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            onTap: () {
              // Открыть просмотр записи (можно добавить позже)
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                      Text(
                        '${entry.date.day}.${entry.date.month}.${entry.date.year}',
                        style: const TextStyle(color: AppColors.primaryBlue),
                      ),
                    ],
                  ),
                  if (entry.time != null)
                    Text(
                      '${entry.time!.hour.toString().padLeft(2, '0')}:${entry.time!.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(color: AppColors.primaryBlue, fontSize: 12),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    entry.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.primaryBlue),
                  ),
                  if (entry.tags.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: entry.tags.map((tag) => Chip(
                        label: Text('#$tag', style: const TextStyle(fontSize: 12)),
                        backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                        visualDensity: VisualDensity.compact,
                      )).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}