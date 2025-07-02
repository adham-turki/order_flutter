class CartItem {
  String? productCode;
  String? productName;
  int quantity;
  double? price;

  CartItem({
    this.productCode,
    this.productName,
    this.quantity = 1,
    this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productCode: json['productCode'],
      productName: json['productName'],
      quantity: json['quantity'] ?? 1,
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productCode': productCode,
      'productName': productName,
      'quantity': quantity,
      'price': price,
    };
  }

  double get totalPrice => (price ?? 0) * quantity;
}