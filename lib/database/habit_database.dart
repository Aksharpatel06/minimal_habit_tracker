import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:minimal_habit_tracker/modals/app_settings.dart';
import 'package:minimal_habit_tracker/modals/habit.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier{
  static late Isar isar;


  /*

  S E T U P

  */

  // I N I T I A L I Z E - D A T A B A S E
  static Future<void> initialize() async{
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.openSync([HabitSchema,AppSettingsSchema], directory: dir.path);
  }

  // Save first date of app startup (for heatmap)
  Future<void> saveFirstLaunchDate()
  async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if(existingSettings==null)
      {
        final settings = AppSettings()..firstLaunchDate = DateTime.now();
        await isar.writeTxn(() => isar.appSettings.put(settings));
      }
  }

  // Get first date of app startup (for heatmap)
  Future<DateTime?> getFirstLaunchDate() async{
    final settings =  await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  /*

  C R U D X O P E R A T I O N S

  */

  // List of habits
  final List<Habit> currentHabit = [];

  // C R E A T E - add a new habbit
  Future<void> addHabit(String habitname) async{
    // create a new habit
    final newHabit = Habit()..name = habitname;

    // save to db
    await isar.writeTxn(() => isar.habits.put(newHabit));

    // re-read from db
    readHabits();
  }

  // R E A D - read saved habits from db
  Future<void> readHabits() async{
    // fetch all habits from db
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    // give to current habits
    currentHabit.clear();
    currentHabit.addAll(fetchedHabits);

    // update UI
    notifyListeners();
  }

  // U P D A T E - check habit on and off
  Future<void> updateHabitCompletion(int id,bool isCompleted)  async{
    // find the specific habit
    final habit = await isar.habits.get(id);

    // update completion status
    if(habit != null)
      {
        await isar.writeTxn(() async{
          // if
        });
      }
  }
}