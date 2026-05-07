import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск'),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Введите запрос...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.primaryBlue),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: AppColors.primaryBlue),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: AppColors.primaryBlue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
                    ),
                  ),
                  onChanged: (value) => setState(() => _searchQuery = value),
                  onSubmitted: (value) {
                    // Выполнить поиск
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _searchQuery.isEmpty
                      ? const Center(
                          child: Text(
                            'Введите текст для поиска',
                            style: TextStyle(color: AppColors.primaryBlue),
                          ),
                        )
                      : ListView.builder(
                          itemCount: 10, // Здесь будут результаты
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('Результат $index', style: const TextStyle(color: AppColors.primaryBlue)),
                              onTap: () {},
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}