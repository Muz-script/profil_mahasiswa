import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/profil_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;

  // Palet warna konsisten (terinspirasi warna foto profil).
  static const _primary = Color(0xFF8D5A3B);
  static const _secondary = Color(0xFFD9A066);

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: brightness,
    ).copyWith(
      primary: isDark ? const Color(0xFFC48A5E) : _primary,
      secondary: _secondary,
      surface: isDark ? const Color(0xFF211A15) : Colors.white,
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor:
          isDark ? const Color(0xFF14100D) : const Color(0xFFFAF5F0),
    );

    return base.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
    );
  }

  void _toggleTheme() => setState(() => _isDark = !_isDark);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: ProfilPage(isDark: _isDark, onToggleTheme: _toggleTheme),
    );
  }
}
