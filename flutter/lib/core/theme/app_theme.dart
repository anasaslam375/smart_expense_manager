import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: AppColors.lightBackground,
      cardTheme: CardThemeData(
        elevation: AppDimensions.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.cardCornerRadius),
        ),
        color: AppColors.lightSurface,
      ),
      appBarTheme: const AppBarTheme(
        elevation: AppDimensions.appBarElevation,
        centerTitle: true,
        backgroundColor: AppColors.transparent,
        foregroundColor: AppColors.lightOnBackground,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: AppDimensions.fabElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.fabCornerRadius),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightInputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputCornerRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputCornerRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputCornerRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: AppColors.darkBackground,
      cardTheme: CardThemeData(
        elevation: AppDimensions.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.cardCornerRadius),
        ),
        color: AppColors.darkSurface,
      ),
      appBarTheme: const AppBarTheme(
        elevation: AppDimensions.appBarElevation,
        centerTitle: true,
        backgroundColor: AppColors.transparent,
        foregroundColor: AppColors.darkOnBackground,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: AppDimensions.fabElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.fabCornerRadius),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkInputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputCornerRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputCornerRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputCornerRadius),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
