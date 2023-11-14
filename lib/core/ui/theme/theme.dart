import 'package:clock/core/ui/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  TextStyle displaySmall = const TextStyle(
    color: AppColors.textColor,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  TextStyle titleSmall = const TextStyle(
    color: AppColors.textColor,
    fontSize: 18,
    fontWeight: FontWeight.w600,
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
    fontFamily: GoogleFonts.roboto().fontFamily,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
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
        elevation: MaterialStateProperty.all(5),
        overlayColor: MaterialStateProperty.all(Colors.grey[850]),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
      ),
    ),
    switchTheme: const SwitchThemeData(
      splashRadius: 0,
    ),
    cardTheme: CardTheme(
      color: AppColors.listTileColor,
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    listTileTheme: ListTileThemeData(
      titleTextStyle: displaySmall.copyWith(fontSize: 28),
      subtitleTextStyle: bodySmall,
      contentPadding: const EdgeInsets.fromLTRB(20, 3, 20, 3),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
    textTheme: TextTheme(
        displaySmall: displaySmall,
        bodySmall: bodySmall,
        titleSmall: titleSmall),
  );
}
