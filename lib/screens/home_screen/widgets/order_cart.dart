import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/constants.dart';
import '../../../providers/meal_provider.dart';

class OrderCart extends StatelessWidget {
  const OrderCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MealProvider>(
      builder: (context, mealProvider, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(right: BorderSide(color: Colors.grey[300]!)),
          ),
          child: Column(
            children: [
              // Cart header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: primaryColor,
                ),
                child: const Row(
                  children: [
                    Icon(Icons.shopping_cart, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'الطلب الحالي',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              // Cart items
              Expanded(
                child: mealProvider.cartItems.isEmpty
                    ? const Center(
                        child: Text(
                          'لا توجد عناصر في السلة',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: mealProvider.cartItems.length,
                        itemBuilder: (context, index) {
                          var item = mealProvider.cartItems[index];
                          return Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(8),
                              leading: IconButton(
                                onPressed: () => mealProvider.removeFromCart(index),
                                icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                              ),
                              title: Text(
                                item.productName ?? '',
                                style: const TextStyle(fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                              ),
                              subtitle: Text(
                                '${item.price?.toStringAsFixed(2)} ₪',
                                style: const TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => mealProvider.increaseQuantity(index),
                                    icon: const Icon(Icons.add, size: 16),
                                  ),
                                  Text('${item.quantity}'),
                                  IconButton(
                                    onPressed: () => mealProvider.decreaseQuantity(index),
                                    icon: const Icon(Icons.remove, size: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              // Total and buttons
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey[300]!)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'المجموع:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${mealProvider.cartTotal.toStringAsFixed(2)} ₪',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: mealProvider.cartItems.isEmpty 
                                ? null 
                                : () => mealProvider.saveOrder(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryColor,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('حفظ الطلب'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: mealProvider.cartItems.isEmpty 
                                ? null 
                                : () => mealProvider.invoiceOrder(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('فاتورة'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}