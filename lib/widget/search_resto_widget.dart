import 'package:app_restoran/common/styles.dart';
import 'package:app_restoran/data/model/resto.dart';
import 'package:app_restoran/provider/provider_database.dart';
import 'package:app_restoran/ui/detail_resto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  final Restaurant restoFound;

  const SearchWidget({
    Key? key,
    required this.restoFound,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(restoFound.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return Material(
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
                          color: secondaryColor,
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
                trailing: isFavorited
                    ? IconButton(
                        icon: const Icon(Icons.favorite),
                        onPressed: () => provider.removeFavorite(restoFound.id),
                      )
                    : IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () => provider.addFavorite(restoFound),
                      ),
                onTap: () => Navigator.pushNamed(context, DetailResto.routeName,
                    arguments: restoFound.id),
              ),
            );
          },
        );
      },
    );
  }
}
