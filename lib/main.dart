import 'package:app_restoran/data/api/api_resto.dart';
import 'package:app_restoran/ui/search_resto_page.dart';
import 'package:flutter/material.dart';
import 'package:app_restoran/common/styles.dart';
import 'package:app_restoran/ui/detail_resto.dart';
import 'package:app_restoran/ui/home_resto.dart';
import 'package:provider/provider.dart';
import 'provider/provider_resto.dart';
import 'provider/provider_searchresto.dart';

void main() {
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
