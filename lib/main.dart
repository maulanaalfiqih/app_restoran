import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:app_restoran/common/navigation.dart';
import 'package:app_restoran/data/api/api_resto.dart';
import 'package:app_restoran/ui/search_resto_page.dart';
import 'package:app_restoran/utils/background_service.dart';
import 'package:app_restoran/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:app_restoran/common/styles.dart';
import 'package:app_restoran/ui/detail_resto.dart';
import 'package:app_restoran/ui/home_resto.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
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
          create: (context) => RestaurantProvider(
            apiService: ApiResto(),
          ),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(
            apiService: ApiResto(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Resto Onlen',
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
                secondary: secondaryColor,
                onPrimary: Colors.black,
              ),
          textTheme: myTextTheme,
          appBarTheme: const AppBarTheme(elevation: 0),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: secondaryColor,
              textStyle: const TextStyle(),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
            ),
          ),
        ),
        navigatorKey: navigatorKey,
        initialRoute: HomeResto.routeName,
        routes: {
          HomeResto.routeName: (context) => const HomeResto(),
          DetailResto.routeName: (context) => DetailResto(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
          SearchRestoPage.routeName: (context) => const SearchRestoPage(),
        },
      ),
    );
  }
}
