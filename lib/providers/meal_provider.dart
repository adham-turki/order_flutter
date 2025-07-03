import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/meal_model.dart';
import '../models/order_model.dart';
import '../models/cart_item.dart';
import '../models/rest_product.dart';
import '../services/networking.dart';
import '../constants/constants.dart';

class MealProvider extends ChangeNotifier {
  List<MealModel> _meals = [];
  List<OrderModel> _orders = [];
  final List<CartItem> _cartItems = [];
  bool _isLoading = false;
  String _statusText = 'Loading menu...';
  int _selectedCategoryIndex = 0;
  ScrollController? _cartScrollController;
  OrderModel? _editingOrder; // Track which order is being edited

  List<MealModel> get meals => _meals;
  List<OrderModel> get orders => _orders;
  List<CartItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  String get statusText => _statusText;
  int get selectedCategoryIndex => _selectedCategoryIndex;
  ScrollController? get cartScrollController => _cartScrollController;
  bool get isEditingOrder => _editingOrder != null;

  void setCartScrollController(ScrollController controller) {
    _cartScrollController = controller;
  }

  double get cartTotal {
    return _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

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
      Map<String, dynamic> body = {};
      NetworkingHelper networking = NetworkingHelper('$apiUrl/mealView/getAll');
      List<dynamic>? response = await networking.postData(body);

      if (response != null) {
        _meals = response.map<MealModel>((item) {
          return MealModel.fromJson(item as Map<String, dynamic>);
        }).toList();
        setStatusText('Ready!');
      } else {
        setStatusText('Failed to load menu');
      }
    } catch (e) {
      setStatusText('Error loading menu');
    }

    _isLoading = false;
    notifyListeners();
  }

  void addToCart(RestProduct product) {
    int existingIndex = _cartItems.indexWhere(
      (item) => item.productCode == product.txtCode,
    );

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(CartItem(
        productCode: product.txtCode,
        productName: product.txtName,
        price: product.dblSellprice,
        quantity: 1,
      ));
    }
    
    notifyListeners();
    
    // Auto-scroll to the last item after adding
    if (_cartScrollController != null && _cartItems.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_cartScrollController!.hasClients) {
          _cartScrollController!.animateTo(
            _cartScrollController!.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void increaseQuantity(int index) {
    if (index < _cartItems.length) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(int index) {
    if (index < _cartItems.length) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeFromCart(int index) {
    if (index < _cartItems.length) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    _editingOrder = null; // Clear editing state when cart is cleared
    notifyListeners();
  }

  void editOrder(OrderModel order) {
    _cartItems.clear();
    _cartItems.addAll(order.items?.map((item) => CartItem(
      productCode: item.productCode,
      productName: item.productName,
      price: item.price,
      quantity: item.quantity ?? 1,
    )) ?? []);
    
    // Store the order being edited but don't remove it from saved orders
    _editingOrder = order;
    
    notifyListeners();
    _showMessage('تم تحميل الطلب للتعديل');
  }

  Future<void> deleteOrder(String orderId) async {
    _orders.removeWhere((o) => o.id == orderId);
    await _removeOrderFromPrefs(orderId);
    notifyListeners();
    _showMessage('تم حذف الطلب بنجاح');
  }

  Future<void> saveOrder() async {
    if (_cartItems.isEmpty) return;
    
    if (_editingOrder != null) {
      // Update the existing order
      _editingOrder!.items = _cartItems.map((item) => OrderItem(
        productCode: item.productCode,
        productName: item.productName,
        quantity: item.quantity,
        price: item.price,
      )).toList();
      _editingOrder!.total = cartTotal;
      _editingOrder!.createdAt = DateTime.now();
      
      // Update in memory
      int index = _orders.indexWhere((o) => o.id == _editingOrder!.id);
      if (index != -1) {
        _orders[index] = _editingOrder!;
      }
      
      // Update in SharedPreferences
      await _updateOrderInPrefs(_editingOrder!);
      _showMessage('تم تحديث الطلب بنجاح!');
      
      _editingOrder = null; // Clear editing state
    } else {
      // Create new order
      String orderId = DateTime.now().millisecondsSinceEpoch.toString();
      OrderModel order = OrderModel(
        id: orderId,
        status: 'saved',
        items: _cartItems.map((item) => OrderItem(
          productCode: item.productCode,
          productName: item.productName,
          quantity: item.quantity,
          price: item.price,
        )).toList(),
        total: cartTotal,
        createdAt: DateTime.now(),
      );

      await _saveOrderToPrefs(order);
      _orders.add(order);
      _showMessage('تم حفظ الطلب بنجاح!');
    }
    
    clearCart();
  }

  Future<void> invoiceOrder() async {
    if (_cartItems.isEmpty) return;
    
    if (_editingOrder != null) {
      // Update the existing order and convert to invoice
      _editingOrder!.items = _cartItems.map((item) => OrderItem(
        productCode: item.productCode,
        productName: item.productName,
        quantity: item.quantity,
        price: item.price,
      )).toList();
      _editingOrder!.total = cartTotal;
      _editingOrder!.status = 'invoiced';
      _editingOrder!.createdAt = DateTime.now();
      
      // Update in memory
      int index = _orders.indexWhere((o) => o.id == _editingOrder!.id);
      if (index != -1) {
        _orders[index] = _editingOrder!;
      }
      
      // Update in SharedPreferences
      await _updateOrderInPrefs(_editingOrder!);
      _showMessage('تم تحديث الطلب وتحويله إلى فاتورة!');
      
      _editingOrder = null; // Clear editing state
    } else {
      // Create new invoice
      String orderId = DateTime.now().millisecondsSinceEpoch.toString();
      OrderModel order = OrderModel(
        id: orderId,
        status: 'invoiced',
        items: _cartItems.map((item) => OrderItem(
          productCode: item.productCode,
          productName: item.productName,
          quantity: item.quantity,
          price: item.price,
        )).toList(),
        total: cartTotal,
        createdAt: DateTime.now(),
      );

      await _saveOrderToPrefs(order);
      _orders.add(order);
      _showMessage('تم إنشاء الفاتورة بنجاح!');
    }
    
    clearCart();
  }

  Future<void> _saveOrderToPrefs(OrderModel order) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> orderStrings = prefs.getStringList('orders') ?? [];
    orderStrings.add(jsonEncode(order.toJson()));
    await prefs.setStringList('orders', orderStrings);
  }

  Future<void> _removeOrderFromPrefs(String orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> orderStrings = prefs.getStringList('orders') ?? [];
    
    orderStrings.removeWhere((orderString) {
      Map<String, dynamic> orderJson = jsonDecode(orderString);
      return orderJson['id'] == orderId;
    });
    
    await prefs.setStringList('orders', orderStrings);
  }

  Future<void> loadSavedOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> orderStrings = prefs.getStringList('orders') ?? [];
    
    _orders = orderStrings.map((orderString) {
      Map<String, dynamic> orderJson = jsonDecode(orderString);
      return OrderModel.fromJson(orderJson);
    }).toList();
    
    notifyListeners();
  }

  Future<void> convertToInvoice(String orderId) async {
    int index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      _orders[index].status = 'invoiced';
      await _updateOrderInPrefs(_orders[index]);
      notifyListeners();
      _showMessage('تم تحويل الطلب إلى فاتورة!');
    }
  }

  Future<void> _updateOrderInPrefs(OrderModel updatedOrder) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> orderStrings = prefs.getStringList('orders') ?? [];
    
    int index = -1;
    for (int i = 0; i < orderStrings.length; i++) {
      Map<String, dynamic> orderJson = jsonDecode(orderStrings[i]);
      if (orderJson['id'] == updatedOrder.id) {
        index = i;
        break;
      }
    }
    
    if (index != -1) {
      orderStrings[index] = jsonEncode(updatedOrder.toJson());
      await prefs.setStringList('orders', orderStrings);
    }
  }

  void _showMessage(String message) {
    print(message);
  }
}