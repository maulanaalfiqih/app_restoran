import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_restoran/data/model/resto.dart';

class ApiResto {
  Future<RestoResult> daftarResto() async {
    final response =
        await http.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));
    if (response.statusCode == 200) {
      return RestoResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Load API');
    }
  }

  Future<DetailRestaurant> detailMenu(String id) async {
    final response = await http
        .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id'));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Load API Detail');
    }
  }

  Future<SearchResto> searchRestaurant(query) async {
    final response = await http
        .get(Uri.parse('https://restaurant-api.dicoding.dev/search?q=$query'));

    if (response.statusCode == 200) {
      return SearchResto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal load API Search');
    }
  }
}
