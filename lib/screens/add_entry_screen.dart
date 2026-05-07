import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../constants/app_colors.dart';
import '../models/journal_entry.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKeyFree = GlobalKey<FormState>();
  final _formKeyPillars = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  final List<String> _selectedTags = [];
  final List<String> _availableTags = ['тревога', 'прогресс', 'триггеры', 'позитив', 'сложности', 'размышления'];

  final _contentController = TextEditingController();

  final _safetyController = TextEditingController();
  final _connectionController = TextEditingController();
  final _calmController = TextEditingController();
  final _effectivenessController = TextEditingController();
  final _hopeController = TextEditingController();

  EntryType _currentType = EntryType.free;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentType = _tabController.index == 0 ? EntryType.free : EntryType.pillars;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    _safetyController.dispose();
    _connectionController.dispose();
    _calmController.dispose();
    _effectivenessController.dispose();
    _hopeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('ru', 'RU'),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Localizations.override(
          context: context,
          locale: const Locale('ru', 'RU'),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: Theme(
              data: Theme.of(context).copyWith(
                timePickerTheme: Theme.of(context).timePickerTheme.copyWith(
                  dayPeriodTextColor: Colors.transparent,
                  dayPeriodColor: Colors.transparent,
                ),
              ),
              child: child!,
            ),
          ),
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  void _saveEntry() {
    final form = _currentType == EntryType.free ? _formKeyFree : _formKeyPillars;
    if (!form.currentState!.validate()) return;

    String content;
    if (_currentType == EntryType.free) {
      content = _contentController.text;
    } else {
      content = '''
Безопасность: ${_safetyController.text}
Связь: ${_connectionController.text}
Спокойствие: ${_calmController.text}
Эффективность: ${_effectivenessController.text}
Надежда: ${_hopeController.text}
''';
    }

    final entry = JournalEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      content: content,
      date: _selectedDate,
      time: _selectedTime,
      type: _currentType,
      tags: _selectedTags,
      safety: _currentType == EntryType.pillars ? _safetyController.text : null,
      connection: _currentType == EntryType.pillars ? _connectionController.text : null,
      calm: _currentType == EntryType.pillars ? _calmController.text : null,
      effectiveness: _currentType == EntryType.pillars ? _effectivenessController.text : null,
      hope: _currentType == EntryType.pillars ? _hopeController.text : null,
    );
    Navigator.pop(context, entry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая запись'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _saveEntry,
            child: const Text('Сохранить', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryBlue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primaryBlue,
          tabs: const [
            Tab(text: 'Свободная форма'),
            Tab(text: 'Столпы устойчивости'),
          ],
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
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildFreeForm(),
              _buildPillarsForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFreeForm() {
    return Form(
      key: _formKeyFree,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCommonFields(),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                hintText: 'Пишите свободно о том, что у вас на уме',
                alignLabelWithHint: true,
              ),
              maxLines: 10,
              validator: (v) => v == null || v.isEmpty ? 'Введите текст' : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPillarsForm() {
    return Form(
      key: _formKeyPillars,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCommonFields(),
            const SizedBox(height: 16),
            _buildPillarField('Безопасность', 'Что заставило вас почувствовать себя в безопасности сегодня?', _safetyController),
            _buildPillarField('Связь', 'Как вы общались с другими?', _connectionController),
            _buildPillarField('Спокойствие', 'Что принесло вам спокойствие или мир?', _calmController),
            _buildPillarField('Эффективность', 'Чего вы достигли? Важны даже маленькие достижения', _effectivenessController),
            _buildPillarField('Надежда', 'Что дает вам надежду на завтра?', _hopeController),
          ],
        ),
      ),
    );
  }

  Widget _buildPillarField(String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(hintText: hint),
            maxLines: 3,
            validator: (v) => v == null || v.isEmpty ? 'Заполните поле' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildCommonFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Дата'),
                subtitle: Text('${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}'),
                trailing: const Icon(Icons.calendar_today, size: 20),
                onTap: _selectDate,
              ),
            ),
            Expanded(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Время'),
                subtitle: Text(_selectedTime != null
                    ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
                    : 'Не указано'),
                trailing: const Icon(Icons.access_time, size: 20),
                onTap: _selectTime,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'Название',
            hintText: 'Введите название записи',
          ),
          validator: (v) => v == null || v.isEmpty ? 'Введите название' : null,
        ),
        const SizedBox(height: 24),
        const Text('Добавить теги', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: _availableTags.map((tag) {
            final isSelected = _selectedTags.contains(tag);
            return FilterChip(
              label: Text('#$tag'),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedTags.add(tag);
                  } else {
                    _selectedTags.remove(tag);
                  }
                });
              },
              backgroundColor: Colors.white,
              selectedColor: AppColors.primaryBlue.withOpacity(0.2),
              checkmarkColor: AppColors.primaryBlue,
              labelStyle: TextStyle(color: isSelected ? AppColors.primaryBlue : Colors.grey[600]),
            );
          }).toList(),
        ),
      ],
    );
  }
}