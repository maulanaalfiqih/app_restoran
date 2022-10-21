import 'package:app_restoran/common/styles.dart';
import 'package:app_restoran/provider/provider_resto.dart';
import 'package:app_restoran/widget/card_resto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_restoran/widget/multi_platform.dart';
import 'package:provider/provider.dart';
import 'package:app_restoran/utils/result_state.dart';

class ListResto extends StatelessWidget {
  const ListResto({Key? key}) : super(key: key);

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: secondaryColor,
            ),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var resto = state.result.restaurants[index];
              return CardResto(resto: resto);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  Widget _androidStyle(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resto Onlen'),
      ),
      body: _buildList(),
    );
  }

  Widget _iosStyle(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Resto Onlen'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiPlatform(androidStyle: _androidStyle, iosStyle: _iosStyle);
  }
}
