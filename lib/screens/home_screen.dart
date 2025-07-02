import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../providers/meal_provider.dart';
import '../models/subcat_details.dart';
import 'widgets/category_tab_bar.dart';
import 'widgets/product_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      
      body: Consumer<MealProvider>(
        builder: (context, mealProvider, child) {
          if (mealProvider.meals.isEmpty) {
            return const Center(child: Text('No meals available'));
          }

          // Get the subcategory details with proper type casting
          List<SubCategoryDetails>? subCatDetails;
          if (selectedCategoryIndex < mealProvider.meals.length) {
            final subCatList = mealProvider.meals[selectedCategoryIndex].subCatDetailsList;
            if (subCatList != null) {
              // Cast from List<Object> to List<SubCategoryDetails>
              subCatDetails = subCatList.cast<SubCategoryDetails>();
            }
          }

          return Column(
            children: [
              CategoryTabBar(
                categories: mealProvider.meals,
                selectedIndex: selectedCategoryIndex,
                onCategorySelected: (index) {
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                },
              ),
              Expanded(
                child: ProductGrid(
                  products: subCatDetails,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}