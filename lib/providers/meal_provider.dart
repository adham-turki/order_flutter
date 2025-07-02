import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../models/order_model.dart';
import '../services/networking.dart';
import '../constants/constants.dart';

class MealProvider extends ChangeNotifier {
  List<MealModel> _meals = [];
  List<OrderModel> _orders = [];
  bool _isLoading = false;
  String _statusText = 'Loading menu...';
  int _selectedCategoryIndex = 0;

  List<MealModel> get meals => _meals;
  List<OrderModel> get orders => _orders;
  bool get isLoading => _isLoading;
  String get statusText => _statusText;
  int get selectedCategoryIndex => _selectedCategoryIndex;

  void setSelectedCategory(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }

  void setStatusText(String status) {
    _statusText = status;
    notifyListeners();
  }

  Future<void> fetchMeals() async {
    _isLoading = true;
    setStatusText('Fetching menu data...');

    try {
      NetworkingHelper networking = NetworkingHelper('$apiUrl/mealView/getAll');
      List<dynamic>? response = await networking.getData();

      if (response != null) {
        _meals = response
            .map((item) => MealModel.fromJson(item as Map<String, dynamic>))
            .toList();
            print('Meals loaded: ${response}');
        setStatusText('Ready!');
      } else {
        setStatusText('Failed to load menu');
      }
    } catch (e) {
      print('Error fetching meals: $e');
      setStatusText('Error loading menu');
    }

    _isLoading = false;
    notifyListeners();
  }

  void addOrder(OrderModel order) {
    _orders.add(order);
    notifyListeners();
  }

  void updateOrderStatus(String orderId, String status) {
    int index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      _orders[index].status = status;
      notifyListeners();
    }
  }
}
