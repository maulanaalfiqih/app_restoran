import 'dart:async';
import 'package:app_restoran/provider/provider_searchresto.dart';
import 'package:app_restoran/widget/search_resto_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

class SearchRestoPage extends StatefulWidget {
  static const routeName = '/search_resto_page';
  static const String searchTitle = 'Cari Resto';

  const SearchRestoPage({Key? key}) : super(key: key);

  @override
  State<SearchRestoPage> createState() => _SearchRestoPageState();
}

class _SearchRestoPageState extends State<SearchRestoPage> {
  late TextEditingController textEditingController;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> subscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
    textEditingController.dispose();
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();

    final SearchProvider searchProvider =
        Provider.of<SearchProvider>(context, listen: false);

    textEditingController = TextEditingController(text: searchProvider.query);
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      setState(() {
        _connectionStatus = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_connectionStatus != ConnectivityResult.none) {
      return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.search),
          title: Consumer<SearchProvider>(
            builder: (context, state, _) => TextField(
              controller: textEditingController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Cari resto',
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
              cursorColor: Colors.black,
              onChanged: (value) {
                Provider.of<SearchProvider>(context, listen: false)
                    .restoSearch(value);
              },
            ),
          ),
        ),
        body: Consumer<SearchProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      color: Color.fromARGB(255, 56, 82, 155),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Mencari resto.....'),
                  ],
                ),
              );
            } else if (state.state == ResultState.hasData) {
              return ListView.builder(
                itemCount: state.search.founded.toInt(),
                itemBuilder: (context, index) {
                  final restoFound = state.search.restaurants[index];
                  return SearchWidget(restoFound: restoFound);
                },
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 56, 82, 155),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Cari Resto Mu..',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 56, 82, 155),
                  ),
                ),
              );
            }
          },
        ),
      );
    } else {
      return const Center(
        child: Text('Anda belum terkoneksi ke internet!'),
      );
    }
  }
}
