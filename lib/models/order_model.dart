class OrderModel {
  String? id;
  String? status; // 'saved' or 'invoiced'
  List<OrderItem>? items;
  double? total;
  DateTime? createdAt;

  OrderModel({this.id, this.status, this.items, this.total, this.createdAt});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      status: json['status'],
      items: json['items'] != null
          ? (json['items'] as List).map((i) => OrderItem.fromJson(i)).toList()
          : null,
      total: json['total'],
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'items': items?.map((i) => i.toJson()).toList(),
      'total': total,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}

class OrderItem {
  String? productCode;
  String? productName;
  int? quantity;
  double? price;

  OrderItem({this.productCode, this.productName, this.quantity, this.price});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productCode: json['productCode'],
      productName: json['productName'],
      quantity: json['quantity'],
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
}