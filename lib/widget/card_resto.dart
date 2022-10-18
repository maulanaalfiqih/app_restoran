import 'package:app_restoran/common/styles.dart';
import 'package:app_restoran/data/model/resto.dart';
import 'package:app_restoran/ui/detail_resto.dart';
import 'package:flutter/material.dart';

class CardResto extends StatelessWidget {
  final Restaurant resto;

  const CardResto({Key? key, required this.resto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag:
              "https://restaurant-api.dicoding.dev/images/small/${resto.pictureId}",
          child: Image.network(
            "https://restaurant-api.dicoding.dev/images/small/${resto.pictureId}",
            width: 100,
          ),
        ),
        title: Text(resto.name),
        subtitle: Text(
          '${resto.city}'
                  '\n'
                  '${resto.rating}'
              .toString(),
        ),
        onTap: () => Navigator.pushNamed(context, DetailResto.routeName,
            arguments: resto.id),
      ),
    );
  }
}
