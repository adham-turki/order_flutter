import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../models/subcat_details.dart';

class SubCategoryTabBar extends StatelessWidget {
  final List<SubCategoryDetails> subCategories;
  final int selectedIndex;
  final Function(int) onSubCategorySelected;

  const SubCategoryTabBar({
    Key? key,
    required this.subCategories,
    required this.selectedIndex,
    required this.onSubCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: subCategories.length,
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSubCategorySelected(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? secondaryColor : Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  subCategories[index].subCat?.txtNamea ?? 'Sub Category',
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}