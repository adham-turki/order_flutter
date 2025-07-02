
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../models/product_details.dart';
import '../../models/rest_product.dart';

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
        childAspectRatio: 0.8,
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
                  flex: 3,
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
                        size: 40,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: [
                        Text(
                          product.txtName ?? 'Product',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Text(
                          '${product.dblSellprice?.toStringAsFixed(2) ?? '0'} ₪',
                          style: const TextStyle(
                            color: primaryColor,
                            
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
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