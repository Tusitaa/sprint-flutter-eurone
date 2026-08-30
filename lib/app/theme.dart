import 'package:flutter/material.dart';

class EuroOnePalette {
  static const primaryNavy = Color(0xFF053A5C);
  static const primaryBlue = Color(0xFF0066A6);
  static const euronTeal = Color(0xFF0E615D);
  static const euronCyan = Color(0xFF00A6C8);
  static const euronGreen = Color(0xFF7CC242);
  static const mintBackground = Color(0xFFE8F7F3);
  static const lightBackground = Color(0xFFF6FAFC);
  static const cardBackground = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF102A43);
  static const textSecondary = Color(0xFF627D98);
  static const textMuted = Color(0xFF829AB1);
  static const borderSoft = Color(0xFFD6E2E3);
  static const success = Color(0xFF16A34A);
  static const attention = Color(0xFFF59E0B);
  static const critical = Color(0xFFDC2626);
  static const info = Color(0xFF0284C7);
  static const neutral = Color(0xFF64748B);
}

class EuroOneStatusColors extends ThemeExtension<EuroOneStatusColors> {
  const EuroOneStatusColors({
    required this.success,
    required this.attention,
    required this.critical,
    required this.info,
    required this.neutral,
  });

  final Color success;
  final Color attention;
  final Color critical;
  final Color info;
  final Color neutral;

  @override
  EuroOneStatusColors copyWith({
    Color? success,
    Color? attention,
    Color? critical,
    Color? info,
    Color? neutral,
  }) {
    return EuroOneStatusColors(
      success: success ?? this.success,
      attention: attention ?? this.attention,
      critical: critical ?? this.critical,
      info: info ?? this.info,
      neutral: neutral ?? this.neutral,
    );
  }

  @override
  EuroOneStatusColors lerp(
    covariant ThemeExtension<EuroOneStatusColors>? other,
    double t,
  ) {
    if (other is! EuroOneStatusColors) {
      return this;
    }
    return EuroOneStatusColors(
      success: Color.lerp(success, other.success, t) ?? success,
      attention: Color.lerp(attention, other.attention, t) ?? attention,
      critical: Color.lerp(critical, other.critical, t) ?? critical,
      info: Color.lerp(info, other.info, t) ?? info,
      neutral: Color.lerp(neutral, other.neutral, t) ?? neutral,
    );
  }
}

ThemeData buildEuroOneTheme() {
  const statusColors = EuroOneStatusColors(
    success: EuroOnePalette.success,
    attention: EuroOnePalette.attention,
    critical: EuroOnePalette.critical,
    info: EuroOnePalette.info,
    neutral: EuroOnePalette.neutral,
  );

  const colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: EuroOnePalette.primaryNavy,
    onPrimary: Colors.white,
    secondary: EuroOnePalette.primaryBlue,
    onSecondary: Colors.white,
    error: EuroOnePalette.critical,
    onError: Colors.white,
    surface: EuroOnePalette.cardBackground,
    onSurface: EuroOnePalette.textPrimary,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme.copyWith(
      tertiary: EuroOnePalette.euronTeal,
      tertiaryContainer: EuroOnePalette.mintBackground,
      onTertiaryContainer: EuroOnePalette.euronTeal,
      secondaryContainer: const Color(0xFFD8EEFA),
      onSecondaryContainer: EuroOnePalette.primaryBlue,
      primaryContainer: const Color(0xFFD5E8F3),
      onPrimaryContainer: EuroOnePalette.primaryNavy,
      surfaceContainerHighest: const Color(0xFFEFF4F7),
      outline: EuroOnePalette.borderSoft,
      onSurfaceVariant: EuroOnePalette.textSecondary,
    ),
    scaffoldBackgroundColor: EuroOnePalette.lightBackground,
    dividerColor: EuroOnePalette.borderSoft,
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: EuroOnePalette.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: EuroOnePalette.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: EuroOnePalette.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: EuroOnePalette.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: EuroOnePalette.textPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: EuroOnePalette.textSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: EuroOnePalette.textSecondary,
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      toolbarHeight: 72,
      scrolledUnderElevation: 0,
      backgroundColor: EuroOnePalette.cardBackground,
      foregroundColor: EuroOnePalette.textPrimary,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: EuroOnePalette.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: EuroOnePalette.borderSoft),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: EuroOnePalette.cardBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      hintStyle: const TextStyle(color: EuroOnePalette.textMuted),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: EuroOnePalette.borderSoft),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: EuroOnePalette.borderSoft),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: EuroOnePalette.primaryBlue,
          width: 1.4,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: EuroOnePalette.critical),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 44),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        backgroundColor: EuroOnePalette.primaryNavy,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 44),
        side: const BorderSide(color: EuroOnePalette.borderSoft),
        foregroundColor: EuroOnePalette.primaryNavy,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      minLeadingWidth: 28,
      dense: false,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFEEF5F9),
      selectedColor: const Color(0xFFD5E8F3),
      labelStyle: const TextStyle(
        color: EuroOnePalette.textSecondary,
        fontWeight: FontWeight.w600,
      ),
      side: const BorderSide(color: EuroOnePalette.borderSoft),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    ),
    extensions: const <ThemeExtension<dynamic>>[statusColors],
  );
}