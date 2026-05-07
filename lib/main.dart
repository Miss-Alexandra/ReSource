import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'constants/app_colors.dart';
import 'screens/home_screen.dart';
import 'screens/emergency_screen.dart';
import 'screens/breathing_exercise_screen.dart';
import 'screens/grounding_screen.dart';
import 'screens/resource_photos_screen.dart';
import 'screens/calming_audio_screen.dart';
import 'screens/search_screen.dart';
import 'screens/add_entry_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/security_screen.dart';
import 'screens/help_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReSource',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ru', 'RU'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru', 'RU'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryBlue,
          brightness: Brightness.light,
          primary: AppColors.primaryBlue,
          onPrimary: Colors.white,
          secondary: AppColors.primaryBlue,
          onSecondary: Colors.white,
          error: AppColors.emergencyRed,
          surface: Colors.white,
          onSurface: AppColors.primaryBlue,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.backgroundStart,   // <-- Фон как верх градиента
          iconTheme: IconThemeData(color: AppColors.primaryBlue),
          titleTextStyle: TextStyle(
            color: AppColors.primaryBlue,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        datePickerTheme: DatePickerThemeData(
          backgroundColor: Colors.white,
          headerBackgroundColor: AppColors.primaryBlue,
          headerForegroundColor: Colors.white,
          dayOverlayColor: WidgetStateProperty.all(AppColors.primaryBlue.withOpacity(0.1)),
          yearOverlayColor: WidgetStateProperty.all(AppColors.primaryBlue.withOpacity(0.1)),
          todayBackgroundColor: WidgetStateProperty.all(AppColors.primaryBlue.withOpacity(0.3)),
          todayForegroundColor: WidgetStateProperty.all(AppColors.primaryBlue),
          rangeSelectionBackgroundColor: AppColors.primaryBlue.withOpacity(0.2),
        ),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.white,
          hourMinuteTextColor: AppColors.primaryBlue,
          dayPeriodTextColor: Colors.transparent,
          dialHandColor: AppColors.primaryBlue,
          dialBackgroundColor: Colors.white,
          entryModeIconColor: AppColors.primaryBlue,
          hourMinuteColor: WidgetStateColor.resolveWith((states) => AppColors.primaryBlue),
          dayPeriodColor: Colors.transparent,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primaryBlue,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryBlue,
            side: const BorderSide(color: AppColors.primaryBlue),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
          selectedColor: AppColors.primaryBlue,
          secondarySelectedColor: AppColors.primaryBlue,
          labelStyle: const TextStyle(color: AppColors.primaryBlue),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.primaryBlue,
          selectionColor: AppColors.primaryBlue.withOpacity(0.3),
          selectionHandleColor: AppColors.primaryBlue,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColors.primaryBlue),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primaryBlue.withOpacity(0.3)),
          ),
          labelStyle: const TextStyle(color: AppColors.primaryBlue),
        ),
      ),
      home: const HomePage(),
      routes: {
        '/emergency': (context) => const EmergencyScreen(),
        '/breathing': (context) => const BreathingExerciseScreen(),
        '/grounding': (context) => const GroundingScreen(),
        '/photos': (context) => const ResourcePhotosScreen(),
        '/audio': (context) => const CalmingAudioScreen(),
        '/search': (context) => const SearchScreen(),
        '/add_entry': (context) => const AddEntryScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/edit_profile': (context) => const EditProfileScreen(),
        '/security': (context) => const SecurityScreen(),
        '/help': (context) => const HelpScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}