import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadqahzakat/Screens/Login/components/colors.dart';
// import 'package:zakat_app/Screens/Login/components/colors.dart';

// import 'constants.dart';

enum AppTheme { Dark, Light }

final Map<AppTheme, ThemeData> kAppThemeData = {
  AppTheme.Dark: ThemeData.dark().copyWith(
    primaryColor: kDarkPrimary,
    scaffoldBackgroundColor: kDarkBg,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 64,
        color: kDarkTextColor,
      ),
      displayMedium: TextStyle(
        fontSize: 32,
        color: kDarkTextColor,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        color: kDarkTextColor,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        color: kDarkTextColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        color: kDarkTextColor,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        color: kDarkTextColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 12,
        color: kDarkTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: kDarkTextColor,
      ),
    ).apply(fontSizeFactor: 1.sp),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        minimumSize: MaterialStateProperty.all(
          Size(double.infinity, 56.h),
        ),
        shape: MaterialStateProperty.all(
          const StadiumBorder(),
        ),
        foregroundColor: MaterialStateProperty.all(
          kDarkTextColor,
        ),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: 16.sp,
            color: kDarkTextColor,
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(kDarkPrimary),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: 16.sp,
            color: kDarkPrimary,
          ),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kDarkBg,
      selectedItemColor: kDarkPrimary,
      selectedIconTheme: IconThemeData(
        color: kDarkPrimary,
        size: 24.sp,
      ),
      unselectedItemColor: kDarkPlaceholderText,
      unselectedIconTheme: IconThemeData(
        color: kDarkPlaceholderText,
        size: 24.sp,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: kDarkBg,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: const IconThemeData(
        color: kDarkTextColor,
      ),
      titleTextStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: kDarkTextColor,
      ),
    ),
    colorScheme: const ColorScheme.dark()
        .copyWith(
          surface: kDarkPlaceholderText,
          primary: kDarkPrimary,
          secondary: kDarkAccent,
        )
        .copyWith(surface: kDarkPlaceholder)
        .copyWith(error: kDarkError),
  ),
  AppTheme.Light: ThemeData.light().copyWith(
    primaryColor: kLightPrimary,
    scaffoldBackgroundColor: kLightBg,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 64,
        color: kLightTextColor,
      ),
      displayMedium: TextStyle(
        fontSize: 32,
        color: kLightTextColor,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        color: kLightTextColor,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        color: kLightTextColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        color: kLightTextColor,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        color: kLightTextColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 12,
        color: kLightTextColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: kLightTextColor,
      ),
    ).apply(fontSizeFactor: 1.sp),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(5),
        minimumSize: MaterialStateProperty.all(
          Size(double.infinity, 56.h),
        ),
        shape: MaterialStateProperty.all(
          const StadiumBorder(),
        ),
        foregroundColor: MaterialStateProperty.all(
          kDarkTextColor,
        ),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: 16.sp,
            color: kDarkTextColor,
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(kLightPrimary),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: 16.sp,
            color: kLightPrimary,
          ),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: kLightPrimary,
      titleTextStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: kDarkTextColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kLightBg,
      selectedItemColor: kLightPrimary,
      selectedIconTheme: IconThemeData(
        color: kLightPrimary,
        size: 24.sp,
      ),
      unselectedItemColor: kLightPlaceholderText,
      unselectedIconTheme: IconThemeData(
        color: kLightPlaceholderText,
        size: 24.sp,
      ),
    ),
    colorScheme: const ColorScheme.light()
        .copyWith(
          surface: kLightPlaceholderText,
          primary: kLightPrimary,
          secondary: kLightAccent,
        )
        .copyWith(surface: kLightPlaceholder)
        .copyWith(error: kLightError),
  ),
};
