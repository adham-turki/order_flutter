import 'department.dart';
import 'product_details.dart';

class SubCategoryDetails {
  DepartModel? subCat;
  List<ProductDetails>? products;

  SubCategoryDetails({
    this.subCat,
    this.products,
  });

  factory SubCategoryDetails.fromJson(Map<String, dynamic> json) {
    return SubCategoryDetails(
      subCat:
          json['subCat'] != null ? DepartModel.fromJson(json['subCat']) : null,
      products: json['products'] != null
          ? (json['products'] as List)
              .map((item) => ProductDetails.fromJson(item))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subCat': subCat?.toJson(),
      'products': products?.map((item) => item.toJson()).toList(),
    };
  }
}
