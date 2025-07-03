import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../providers/meal_provider.dart';
import 'widgets/order_list.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  _loadOrders() => Provider.of<MealProvider>(context, listen: false).loadSavedOrders();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Back Button Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: primaryColor),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'الطلبات',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            // Custom Tab Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTabButton(
                      'الطلبات المحفوظة',
                      Icons.bookmark_outline,
                      0,
                    ),
                  ),
                  Expanded(
                    child: _buildTabButton(
                      'الطلبات المفوترة',
                      Icons.receipt_long,
                      1,
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: Consumer<MealProvider>(
                builder: (context, mealProvider, child) {
                  final savedOrders = mealProvider.orders.where((o) => o.status == 'saved').toList();
                  final invoicedOrders = mealProvider.orders.where((o) => o.status == 'invoiced').toList();
                  
                  // Sort orders by creation date in descending order (newest first)
                  savedOrders.sort((a, b) {
                    if (a.createdAt == null && b.createdAt == null) return 0;
                    if (a.createdAt == null) return 1;
                    if (b.createdAt == null) return -1;
                    return b.createdAt!.compareTo(a.createdAt!);
                  });
                  
                  invoicedOrders.sort((a, b) {
                    if (a.createdAt == null && b.createdAt == null) return 0;
                    if (a.createdAt == null) return 1;
                    if (b.createdAt == null) return -1;
                    return b.createdAt!.compareTo(a.createdAt!);
                  });
                  
                  return selectedTab == 0
                      ? OrderList(
                          orders: savedOrders,
                          canEdit: true,
                          provider: mealProvider,
                          onEdit: () => Navigator.pop(context),
                        )
                      : OrderList(
                          orders: invoicedOrders,
                          canEdit: false,
                          provider: mealProvider,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, IconData icon, int index) {
    bool isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade600,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}