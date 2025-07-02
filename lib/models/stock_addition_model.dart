class StockAdditionModel {
  String? txtKey;
  String? txtStkcode;
  String? txtDescription;
  double? dblPrice;
  String? datCreationdate;

  StockAdditionModel({
    this.txtKey,
    this.txtStkcode,
    this.txtDescription,
    this.dblPrice,
    this.datCreationdate,
  });

  factory StockAdditionModel.fromJson(Map<String, dynamic> json) {
    return StockAdditionModel(
      txtKey: json['txtKey'],
      txtStkcode: json['txtStkcode'],
      txtDescription: json['txtDescription'],
      dblPrice: json['dblPrice'],
      datCreationdate: json['datCreationdate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'txtKey': txtKey,
      'txtStkcode': txtStkcode,
      'txtDescription': txtDescription,
      'dblPrice': dblPrice,
      'datCreationdate': datCreationdate,
    };
  }
}
