import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/journal_entry.dart';
import 'home_content.dart';
import 'journal_screen.dart';
import 'statistics_screen.dart';
import 'profile_screen.dart';
import 'add_entry_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<JournalEntry> _journalEntries = [];
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeContent(),
      JournalScreen(entries: _journalEntries),
      const StatisticsScreen(),
      const ProfileScreen(), // теперь профиль вместо настроек
    ];
  }

  void _addJournalEntry(JournalEntry entry) {
    setState(() {
      _journalEntries.insert(0, entry);
    });
  }

  Future<void> _openAddEntryScreen() async {
    final entry = await Navigator.push<JournalEntry>(
      context,
      MaterialPageRoute(builder: (_) => const AddEntryScreen()),
    );
    if (entry != null) {
      _addJournalEntry(entry);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_currentIndex == 1) {
            await _openAddEntryScreen();
          } else {
            setState(() => _currentIndex = 1);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _openAddEntryScreen();
            });
          }
        },
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppColors.primaryBlue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 20,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ],
        ),
      ),
    );
  }
}