import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TagSelectorWidget extends StatefulWidget {
  final List<String> selectedTags;
  final Function(List<String>) onTagsChanged;
  const TagSelectorWidget({super.key, required this.selectedTags, required this.onTagsChanged});

  @override
  State<TagSelectorWidget> createState() => _TagSelectorWidgetState();
}

class _TagSelectorWidgetState extends State<TagSelectorWidget> {
  static const List<String> availableTags = [
    'тревога', 'прогресс', 'триггеры', 'позитив', 'сложности', 'размышления',
  ];
  
  late List<String> _tempSelected;
  
  @override
  void initState() {
    super.initState();
    _tempSelected = List.from(widget.selectedTags);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Добавить теги', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: availableTags.map((tag) {
              final isSelected = _tempSelected.contains(tag);
              return FilterChip(
                label: Text(tag),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _tempSelected.add(tag);
                    } else {
                      _tempSelected.remove(tag);
                    }
                  });
                },
                selectedColor: AppColors.primaryBlue.withOpacity(0.2),
                checkmarkColor: AppColors.primaryBlue,
                labelStyle: TextStyle(color: isSelected ? AppColors.primaryBlue : AppColors.textPrimary),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Отмена', style: TextStyle(color: AppColors.textSecondary)),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  widget.onTagsChanged(_tempSelected);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Готово'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}