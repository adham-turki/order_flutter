import 'package:flutter/material.dart';
import '../../../models/order_model.dart';
import '../../../providers/meal_provider.dart';
import 'order_card.dart';

class OrderList extends StatelessWidget {
  final List<OrderModel> orders;
  final bool canEdit;
  final MealProvider provider;
  final VoidCallback? onEdit;

  const OrderList({
    super.key,
    required this.orders,
    required this.canEdit,
    required this.provider,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              canEdit ? Icons.bookmark_border : Icons.receipt_outlined,
              size: 64,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              canEdit ? 'لا توجد طلبات محفوظة' : 'لا توجد طلبات مفوترة',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          for (int i = 0; i < orders.length; i += 2)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: OrderCard(
                      order: orders[i],
                      canEdit: canEdit,
                      provider: provider,
                      onEdit: onEdit,
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (i + 1 < orders.length)
                    Expanded(
                      child: OrderCard(
                        order: orders[i + 1],
                        canEdit: canEdit,
                        provider: provider,
                        onEdit: onEdit,
                      ),
                    )
                  else
                    const Expanded(child: SizedBox()),
                ],
              ),
            ),
        ],
      ),
    );
  }
}