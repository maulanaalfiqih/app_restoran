import 'package:app_restoran/data/model/resto.dart';
import 'package:app_restoran/ui/detail_resto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_restoran/common/navigation.dart';
import 'package:app_restoran/provider/provider_database.dart';

class CardResto extends StatelessWidget {
  final Restaurant resto;

  const CardResto({Key? key, required this.resto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(resto.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return Material(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Hero(
                  tag: resto.id,
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
                trailing: isFavorited
                    ? IconButton(
                        icon: const Icon(Icons.favorite),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.removeFavorite(resto.id),
                      )
                    : IconButton(
                        icon: const Icon(Icons.favorite_border),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.addFavorite(resto),
                      ),
                onTap: () =>
                    Navigation.intentWithData(DetailResto.routeName, resto.id),
              ),
            );
          },
        );
      },
    );
  }
}
