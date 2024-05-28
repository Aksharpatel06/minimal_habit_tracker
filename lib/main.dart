import 'package:flutter/material.dart';
import 'package:minimal_habit_tracker/database/habit_database.dart';
import 'package:minimal_habit_tracker/page/home_page.dart';
import 'package:minimal_habit_tracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize database
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();
  runApp(MultiProvider(providers: [
    // theme provider
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
    ),

    // habits provider
    ChangeNotifierProvider(
      create: (context) => HabitDatabase(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomePage(),
    );
  }
}
