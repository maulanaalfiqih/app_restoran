import 'package:app_restoran/common/styles.dart';
import 'package:app_restoran/data/model/resto.dart';
import 'package:app_restoran/ui/detail_resto.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final Restaurant restoFound;

  const SearchWidget({
    Key? key,
    required this.restoFound,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restoFound.id,
          child: Image.network(
            "https://restaurant-api.dicoding.dev/images/small/${restoFound.pictureId}",
            width: 100,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return const CircularProgressIndicator(
                  color: Colors.blue,
                );
              }
            },
            fit: BoxFit.cover,
          ),
        ),
        title: Text(restoFound.name),
        subtitle: Text(
          '${restoFound.city}'
                  '\n'
                  '${restoFound.rating}'
              .toString(),
        ),
        onTap: () => Navigator.pushNamed(context, DetailResto.routeName,
            arguments: restoFound.id),
      ),
    );
  }
}
