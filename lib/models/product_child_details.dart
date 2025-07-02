import 'rest_product.dart';
import 'stock_addition_model.dart';

class ProductChildDetails {
  RestProduct? productChild;
  List<RestProduct>? mainProductsList;
  List<StockAdditionModel>? stockAdditionsList;

  ProductChildDetails({
    this.productChild,
    this.mainProductsList,
    this.stockAdditionsList,
  });

  factory ProductChildDetails.fromJson(Map<String, dynamic> json) {
    return ProductChildDetails(
      productChild: json['productChild'] != null
          ? RestProduct.fromJson(json['productChild'])
          : null,
      mainProductsList: json['mainProductsList'] != null
          ? (json['mainProductsList'] as List)
              .map((item) => RestProduct.fromJson(item))
              .toList()
          : null,
      stockAdditionsList: json['stockAdditionsList'] != null
          ? (json['stockAdditionsList'] as List)
              .map((item) => StockAdditionModel.fromJson(item))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productChild': productChild?.toJson(),
      'mainProductsList':
          mainProductsList?.map((item) => item.toJson()).toList(),
      'stockAdditionsList':
          stockAdditionsList?.map((item) => item.toJson()).toList(),
    };
  }
}
