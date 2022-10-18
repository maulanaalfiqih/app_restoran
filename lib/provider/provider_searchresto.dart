import 'package:flutter/material.dart';
import 'package:app_restoran/data/api/api_resto.dart';
import 'package:app_restoran/data/model/resto.dart';

enum ResultState { loading, error, noData, hasData }

class SearchProvider extends ChangeNotifier {
  final ApiResto apiService;
  String query;

  SearchProvider({
    required this.apiService,
    this.query = '',
  }) {
    _fetchAllRestaurant(query);
  }

  late SearchResto _searchResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  SearchResto get search => _searchResult;
  ResultState? get state => _state;

  restoSearch(String newValue) {
    query = newValue;
    _fetchAllRestaurant(query);
    notifyListeners();
  }

  Future<dynamic> _fetchAllRestaurant(value) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(value);
      if (restaurant.restaurants.isNotEmpty) {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchResult = restaurant;
      } else {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Data resto tidak ada';
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Anda belum terkoneksi ke internet!';
    }
  }
}
