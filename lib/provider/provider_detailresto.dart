import 'dart:async';
import 'package:app_restoran/data/api/api_resto.dart';
import 'package:app_restoran/data/model/resto.dart';
import 'package:flutter/material.dart';

enum ResultState { loading, noData, hasData, error }

class DetailRestoProvider extends ChangeNotifier {
  final ApiResto apiService;
  final String id;

  DetailRestoProvider({required this.apiService, required this.id}) {
    _fetchAllRestaurant(id);
  }

  late DetailRestaurant _detailRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  DetailRestaurant get result => _detailRestaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.detailMenu(id);
      if (detailRestaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = detailRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Anda belum terkoneksi ke internet!';
    }
  }
}
