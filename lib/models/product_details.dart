import 'product_child_details.dart';
import 'rest_product.dart';
import 'stock_addition_model.dart';
import 'stock_option_model.dart';

class ProductDetails {
  RestProduct? product;
  List<ProductChildDetails>? productChildrenList;
  List<StockOptionModel>? stockOptionsList;
  List<StockAdditionModel>? stockAdditionsList;
  List<RestProduct>? mainProductsList;

  ProductDetails({
    this.product,
    this.productChildrenList,
    this.stockOptionsList,
    this.stockAdditionsList,
    this.mainProductsList,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      product: json['product'] != null
          ? RestProduct.fromJson(json['product'])
          : null,
      productChildrenList: json['productChildrenList'] != null
          ? (json['productChildrenList'] as List)
              .map((item) => ProductChildDetails.fromJson(item))
              .toList()
          : null,
      stockOptionsList: json['stockOptionsList'] != null
          ? (json['stockOptionsList'] as List)
              .map((item) => StockOptionModel.fromJson(item))
              .toList()
          : null,
      stockAdditionsList: json['stockAdditionsList'] != null
          ? (json['stockAdditionsList'] as List)
              .map((item) => StockAdditionModel.fromJson(item))
              .toList()
          : null,
      mainProductsList: json['mainProductsList'] != null
          ? (json['mainProductsList'] as List)
              .map((item) => RestProduct.fromJson(item))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product?.toJson(),
      'productChildrenList':
          productChildrenList?.map((item) => item.toJson()).toList(),
      'stockOptionsList':
          stockOptionsList?.map((item) => item.toJson()).toList(),
      'stockAdditionsList':
          stockAdditionsList?.map((item) => item.toJson()).toList(),
      'mainProductsList':
          mainProductsList?.map((item) => item.toJson()).toList(),
    };
  }

  void setProduct(RestProduct? newProduct) {
    product = newProduct;
  }

  void setProductChildrenList(
      List<ProductChildDetails>? newProductChildrenList) {
    productChildrenList = newProductChildrenList;
  }

  void setStockOptionsList(List<StockOptionModel>? newStockOptionsList) {
    stockOptionsList = newStockOptionsList;
  }

  void setStockAdditionsList(List<StockAdditionModel>? newStockAdditionsList) {
    stockAdditionsList = newStockAdditionsList;
  }

  void emptyValues() {
    product = null;
    stockOptionsList = null;
    stockAdditionsList = null;
  }
}
