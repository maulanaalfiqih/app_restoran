import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:app_restoran/common/navigation.dart';
import 'package:app_restoran/data/api/api_resto.dart';
import 'package:app_restoran/data/db/database_helper.dart';
import 'package:app_restoran/provider/provider_database.dart';
import 'package:app_restoran/provider/provider_preferences.dart';
import 'package:app_restoran/provider/provider_scheduling_resto.dart';
import 'package:app_restoran/ui/search_resto_page.dart';
import 'package:app_restoran/utils/background_service.dart';
import 'package:app_restoran/utils/notification_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_restoran/ui/detail_resto.dart';
import 'package:app_restoran/ui/home_resto.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/preferences/preferences_helper.dart';
import 'provider/provider_resto.dart';
import 'provider/provider_searchresto.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<RestaurantProvider>(
            create: (_) => RestaurantProvider(
              apiService: ApiResto(),
            ),
          ),
          ChangeNotifierProvider<SearchProvider>(
            create: (_) => SearchProvider(
              apiService: ApiResto(),
            ),
          ),
          ChangeNotifierProvider<SchedulingProvider>(
            create: (_) => SchedulingProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          ),
          ChangeNotifierProvider<DatabaseProvider>(
            create: (_) => DatabaseProvider(
              databaseHelper: DatabaseHelper(),
            ),
          ),
        ],
        child: Consumer<PreferencesProvider>(
          builder: (context, provider, child) {
            return MaterialApp(
              title: 'Resto Onlen',
              theme: provider.themeData,
              builder: (context, child) {
                return CupertinoTheme(
                  data: CupertinoThemeData(
                    brightness: provider.isDarkTheme
                        ? Brightness.dark
                        : Brightness.light,
                  ),
                  child: Material(
                    child: child,
                  ),
                );
              },
              navigatorKey: navigatorKey,
              initialRoute: HomeResto.routeName,
              routes: {
                HomeResto.routeName: (context) => const HomeResto(),
                DetailResto.routeName: (context) => DetailResto(
                      id: ModalRoute.of(context)?.settings.arguments as String,
                    ),
                SearchRestoPage.routeName: (context) => const SearchRestoPage(),
              },
            );
          },
        ));
  }
}
