import 'package:app_restoran/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_restoran/provider/provider_detailresto.dart';
import 'package:app_restoran/data/api/api_resto.dart';

class DetailResto extends StatelessWidget {
  static const routeName = '/detail_resto';

  final String id;

  const DetailResto({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestoProvider>(
      create: (_) =>
          DetailRestoProvider(apiService: ApiResto(Client()), id: id),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Resto Onlen'),
        ),
        body: SafeArea(
          child: Consumer<DetailRestoProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: secondaryColor,
                ));
              } else if (state.state == ResultState.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(
                          "https://restaurant-api.dicoding.dev/images/large/${state.result.restaurant.pictureId}"),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.result.restaurant.name,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const Divider(
                              color: secondaryColor,
                            ),
                            Text(
                              state.result.restaurant.description,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            const Divider(
                              color: secondaryColor,
                            ),
                            Text("Kategori : ",
                                style: Theme.of(context).textTheme.headline5),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  state.result.restaurant.categories.length,
                              itemBuilder: (context, index) {
                                return Text(state
                                    .result.restaurant.categories[index].name);
                              },
                            ),
                            const Divider(
                              color: secondaryColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Icon(
                                      Icons.location_city,
                                      color: secondaryColor,
                                    ),
                                    Text(
                                      state.result.restaurant.city,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: secondaryColor,
                                    ),
                                    Text(
                                      state.result.restaurant.rating.toString(),
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const Divider(
                              color: secondaryColor,
                            ),
                            const Text("Menu Makanan : "),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  state.result.restaurant.menus.foods.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(state.result.restaurant.menus
                                        .foods[index].name),
                                  ),
                                );
                              },
                            ),
                            const Divider(
                              color: secondaryColor,
                            ),
                            const Text("Menu Minuman : "),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  state.result.restaurant.menus.drinks.length,
                              itemBuilder: (contex, index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(state.result.restaurant.menus
                                        .drinks[index].name),
                                  ),
                                );
                              },
                            ),
                            const Divider(
                              color: secondaryColor,
                            ),
                            Text("Apa Kata Mereka : ",
                                style: Theme.of(context).textTheme.headline5),
                            const Divider(
                              color: secondaryColor,
                            ),
                            GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20),
                                itemCount: state
                                    .result.restaurant.customerReviews.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 0.5,
                                            spreadRadius: 0.1,
                                            offset: Offset(
                                              1.0,
                                              1.0,
                                            ),
                                          )
                                        ]),
                                    child: Text(
                                      state.result.restaurant
                                              .customerReviews[index].date +
                                          "\n" +
                                          state.result.restaurant
                                              .customerReviews[index].name +
                                          "\n" +
                                          state.result.restaurant
                                              .customerReviews[index].review,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: LaunchButton(
                                '',
                                () async {
                                  await openUrl(
                                      "https://wa.me/+6282181872936?text=Permisi%20Saya%20ingin%20mereservasi%20resto%20${state.result.restaurant.name}%20...");
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state.state == ResultState.noData ||
                  state.state == ResultState.error) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(height: 8),
                      Text(state.message),
                      const SizedBox(height: 8),
                      const Center(child: Text('Data Tidak Dapat Ditampilkan')),
                    ],
                  ),
                );
              } else {
                return const Center(
                    child: Text('Anda belum terkoneksi ke intrernet'));
              }
            },
          ),
        ),
      ),
    );
  }
}

class LaunchButton extends StatelessWidget {
  final String text;
  final VoidCallback? tap;

  const LaunchButton(this.text, this.tap, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        child: const Text('Reservasi Sekarang'),
        onPressed: tap,
      ),
    );
  }
}

Future<void> openUrl(String url,
    {bool forceWebView = false, bool enableJavaScript = false}) async {
  await launch(url);
}
