import 'package:app_restoran/data/api/api_resto.dart';
import 'package:app_restoran/data/model/resto.dart';
import 'package:flutter/material.dart';
import 'package:app_restoran/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiResto apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestoResult _restoResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestoResult get result => _restoResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final resto = await apiService.daftarResto();
      if (resto.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restoResult = resto;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Anda belum terkoneksi ke internet!';
    }
  }
}
