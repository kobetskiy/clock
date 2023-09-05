import 'package:clock/features/core/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  TextStyle displaySmall = const TextStyle(
    color: AppColors.textColor,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  TextStyle titleMedium = const TextStyle(
    color: AppColors.textColor,
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );
  TextStyle bodySmall = const TextStyle(
    color: AppColors.subtitleColor,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      // backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.textColor,
      iconSize: 32,
      shape: CircleBorder(),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.textColor,
      size: 26,
    ),
    dividerTheme: const DividerThemeData(
      space: 0,
      indent: 0,
      thickness: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.listTileColor),
        foregroundColor: MaterialStateProperty.all(AppColors.dangerRedColor),
        elevation: MaterialStateProperty.all(5),
        overlayColor: MaterialStateProperty.all(Colors.grey[850]),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 60)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
    ),
    switchTheme: const SwitchThemeData(
      splashRadius: 0,
    ),
    timePickerTheme: TimePickerThemeData(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
    cardTheme: CardTheme(
      color: AppColors.listTileColor,
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: titleMedium,
      subtitleTextStyle: bodySmall,
      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
    textTheme: GoogleFonts.robotoTextTheme(
      TextTheme(
        displaySmall: displaySmall,
        titleMedium: titleMedium,
        bodySmall: bodySmall,
      ),
    ),
  );
}
