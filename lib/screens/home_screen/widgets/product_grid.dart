// ignore_for_file: deprecated_member_use

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
      padding: const EdgeInsets.all(12), // Reduced from 16
      
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, 
        childAspectRatio: 1.4, 
        crossAxisSpacing: 8, 
        mainAxisSpacing: 8, // Reduced from 12
        
      ),
      
      itemCount: products!.length,
      itemBuilder: (context, index) {
        var product = products![index].product;
        if (product == null) return const SizedBox();
        
        return GestureDetector(
          onTap: () => onProductTap(product),
          child: Card(
            color: const Color.fromARGB(255, 213, 211, 222),
            elevation: 2, // Reduced from 4
            margin: EdgeInsets.zero, // Remove default card margin
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Reduced from 12
            ),
            child: Padding(
              padding: const EdgeInsets.all(6), // Reduced padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon container - much smaller
                  Container(
                    width: 32, // Fixed small size
                    height: 32,
                    decoration: BoxDecoration(
                      color: thirdColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.fastfood,
                      size: 34, // Smaller icon
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 4), // Small spacing
                  
                  // Product name - single line only
                  Text(
                    product.txtName ?? 'Product',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14, // Smaller font
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 2),
                  
                  // Price
                  Text(
                    '${product.dblSellprice?.toStringAsFixed(2) ?? '0'} ₪',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12, // Smaller price font
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}