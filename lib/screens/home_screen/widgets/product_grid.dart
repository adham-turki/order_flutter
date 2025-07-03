import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../models/product_details.dart';
import '../../../models/rest_product.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductDetails>? products;
  final Function(RestProduct) onProductTap;

  const ProductGrid({
    super.key, 
    this.products,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    if (products == null || products!.isEmpty) {
      return const Center(child: Text('No products available'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.1, // Further increased for more compact cards
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: products!.length,
      itemBuilder: (context, index) {
        var product = products![index].product;
        if (product == null) return const SizedBox();
        
        return GestureDetector(
          onTap: () => onProductTap(product),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1, // Reduced from 2 to 1 to make icon container much smaller
                  child: Container(
                    decoration: BoxDecoration(
                      color: thirdColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.fastfood,
                        size: 24, // Further reduced from 28 to 24
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1, // Reduced from 2 to 1 to make text container more compact
                  child: Padding(
                    padding: const EdgeInsets.all(4.0), // Reduced from 6.0 to 4.0
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.txtName ?? 'Product',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10, // Reduced from 11 to 10
                          ),
                          maxLines: 1, // Reduced from 2 to 1 line for product name
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2), // Small spacing between texts
                        Text(
                          '${product.dblSellprice?.toStringAsFixed(2) ?? '0'} ₪',
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12, // Reduced from 13 to 12
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}