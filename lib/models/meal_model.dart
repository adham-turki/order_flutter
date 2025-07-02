import 'department.dart';
import 'subcat_details.dart';

class MealModel {
  DepartModel? productCat;
  List<SubCategoryDetails>? subCatDetailsList;

  MealModel({
    this.productCat,
    this.subCatDetailsList,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      productCat: json['productCat'] != null
          ? DepartModel.fromJson(json['productCat'])
          : null,
      subCatDetailsList: json['subCatDetailsList'] != null
          ? (json['subCatDetailsList'] as List)
              .map((item) => SubCategoryDetails.fromJson(item))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productCat': productCat?.toJson(),
      'subCatDetailsList':
          subCatDetailsList?.map((item) => item.toJson()).toList(),
    };
  }
}
