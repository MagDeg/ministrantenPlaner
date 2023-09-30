import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ministranten_planer_web/authentication/init_page.dart';
import 'package:ministranten_planer_web/screens/actual_plan/actual_plan_screen.dart';
import 'package:ministranten_planer_web/screens/contact/contact_screen.dart';
import 'package:ministranten_planer_web/screens/ministranten_screen.dart';
import 'package:ministranten_planer_web/screens/new_plan/new_plan_screen.dart';
import 'database/database.dart';
import 'functions/showSnackbar.dart';
import 'main_screen.dart';
import 'package:flutter/material.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();

  runApp(MaterialApp(
    scaffoldMessengerKey: Message.messangerKey,
    theme: ThemeData(
        primaryColor: const Color(0xFFffbe00),
        primarySwatch: const MaterialColor(0xFFffbe00, <int, Color>{
          50: Color(0xFFffbe00),
          100: Color(0xFFffbe00),
          200: Color(0xFFffbe00),
          300: Color(0xFFffbe00),
          400: Color(0xFFffbe00),
          500: Color(0xFFffbe00),
          600: Color(0xFFffbe00),
          700: Color(0xFFffbe00),
          800: Color(0xFFffbe00),
          900: Color(0xFFffbe00),
        })),
    routes: {
      '/mainPage': (_) => const MainScreen(),
      '/newPlanPage': (_) => const NewPlanScreen(),
      '/initPage': (_) => const InitPage(),
      '/actualPlanPage': (_) => const ActualPlanScreen(),
      '/contactPage': (_) => const ContactScreen(),
      '/ministrantenListPage': (_) => const MinistrantenListScreen(),
    },
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: const [Locale("de")],
    home: const MainScreen(),
  ));

}
