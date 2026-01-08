import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../data/mock_data.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];
  bool _loading = false;

  List<Order> get orders => _orders;
  bool get loading => _loading;

  OrdersProvider() {
    // Load mock orders on initialization
    _orders = List.from(mockOrders);
  }

  void addOrder(Order order) {
    _orders.insert(0, order);
    notifyListeners();
  }

  Future<void> refreshOrders() async {
    _loading = true;
    notifyListeners();
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    _orders = List.from(mockOrders);
    _loading = false;
    notifyListeners();
  }

  Future<bool> deleteOrder(int orderId) async {
    try {
      _orders.removeWhere((order) => order.id == orderId);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
