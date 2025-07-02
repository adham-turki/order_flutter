import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/constants.dart';
import '../../providers/meal_provider.dart';
import '../../models/order_model.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _loadOrders();
    _animationController.forward();
  }

  _loadOrders() => Provider.of<MealProvider>(context, listen: false).loadSavedOrders();

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الطلبات', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(icon: Icon(Icons.bookmark_outline, size: 20), text: 'محفوظة'),
            Tab(icon: Icon(Icons.receipt_long, size: 20), text: 'مفوترة'),
          ],
        ),
      ),
      body: Consumer<MealProvider>(
        builder: (context, mealProvider, child) {
          final savedOrders = mealProvider.orders.where((o) => o.status == 'saved').toList();
          final invoicedOrders = mealProvider.orders.where((o) => o.status == 'invoiced').toList();
          
          return TabBarView(
            controller: _tabController,
            children: [
              _buildOrderList(savedOrders, true, mealProvider),
              _buildOrderList(invoicedOrders, false, mealProvider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOrderList(List<OrderModel> orders, bool canEdit, MealProvider provider) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(canEdit ? Icons.bookmark_border : Icons.receipt_outlined, 
                 size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(canEdit ? 'لا توجد طلبات محفوظة' : 'لا توجد طلبات مفوترة',
                 style: TextStyle(fontSize: 18, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
          ],
        ),
      );
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
                .animate(CurvedAnimation(parent: _animationController, curve: Interval(index * 0.1, 1.0))),
            child: FadeTransition(
              opacity: CurvedAnimation(parent: _animationController, curve: Interval(index * 0.1, 1.0)),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [primaryColor.withOpacity(0.1), Colors.transparent],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (canEdit) ...[
                                  Material(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        provider.editOrder(order);
                                        Navigator.pop(context);
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.edit, size: 16, color: Colors.white),
                                            SizedBox(width: 4),
                                            Text('تعديل', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Material(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () => provider.convertToInvoice(order.id!),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.receipt, size: 16, color: Colors.white),
                                            SizedBox(width: 4),
                                            Text('فاتورة', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text('#${order.id?.substring(order.id!.length - 6)}',
                                       style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('${order.items?.length ?? 0} عنصر', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                                const SizedBox(width: 4),
                                Icon(Icons.shopping_bag_outlined, size: 16, color: Colors.grey.shade600),
                                const SizedBox(width: 16),
                                Text(_formatDate(order.createdAt), style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                                const SizedBox(width: 4),
                                Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text('${order.total?.toStringAsFixed(2)} ₪',
                                 style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor)),
                          ],
                        ),
                      ),
                      if (order.items?.isNotEmpty == true)
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: order.items!.take(3).map((item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('${(item.price! * item.quantity!).toStringAsFixed(2)} ₪',
                                       style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                                  const Spacer(),
                                  Text('${item.quantity}x ${item.productName}', 
                                       style: const TextStyle(fontSize: 13),
                                       textDirection: TextDirection.rtl,),
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 6, height: 6,
                                    decoration: BoxDecoration(color: primaryColor.withOpacity(0.6), shape: BoxShape.circle),
                                  ),
                                ],
                              ),
                            )).toList()
                              ..addAll(order.items!.length > 3 ? [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text('+ ${order.items!.length - 3} عنصر آخر',
                                       style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontStyle: FontStyle.italic),
                                       textDirection: TextDirection.rtl,),
                                )
                              ] : []),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'غير معروف';
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}