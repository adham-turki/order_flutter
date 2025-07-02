import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../providers/meal_provider.dart';
import '../models/subcat_details.dart';
import '../models/product_details.dart';
import 'widgets/category_tab_bar.dart';
import 'widgets/subcategory_tab_bar.dart';
import 'widgets/product_grid.dart';
import 'widgets/order_cart.dart';
import 'orders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategoryIndex = 0;
  int selectedSubCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      
      
      body: Consumer<MealProvider>(
        builder: (context, mealProvider, child) {
          if (mealProvider.meals.isEmpty) {
            return const Center(child: Text('No meals available'));
          }

          List<SubCategoryDetails>? subCategories;
          List<ProductDetails>? products;

          if (selectedCategoryIndex < mealProvider.meals.length) {
            subCategories = mealProvider.meals[selectedCategoryIndex].subCatDetailsList;
            
            if (subCategories != null && 
                selectedSubCategoryIndex < subCategories.length) {
              products = subCategories[selectedSubCategoryIndex].products;
            }
          }

          return Column(
            children: [
              // Main categories
              CategoryTabBar(
                categories: mealProvider.meals,
                selectedIndex: selectedCategoryIndex,
                onCategorySelected: (index) {
                  setState(() {
                    selectedCategoryIndex = index;
                    selectedSubCategoryIndex = 0; // Reset subcategory
                  });
                },
              ),
              
              // Sub categories
              if (subCategories != null)
                SubCategoryTabBar(
                  subCategories: subCategories,
                  selectedIndex: selectedSubCategoryIndex,
                  onSubCategorySelected: (index) {
                    setState(() {
                      selectedSubCategoryIndex = index;
                    });
                  },
                ),

              // Products grid and cart
              Expanded(
                child: Row(
                  children: [
                     const Expanded(
                      flex: 30,
                      child: OrderCart(),
                    ),
                    // Products (70%)
                    Expanded(
                      flex: 70,
                      child: ProductGrid(
                        products: products,
                        onProductTap: (product) {
                          mealProvider.addToCart(product);
                        },
                      ),
                    ),
                    
                   
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OrdersScreen()),
          );
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.receipt_long, color: Colors.white),
      ),
    );
  }
}