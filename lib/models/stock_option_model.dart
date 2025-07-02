class StockOptionModel {
  String? txtKey;
  String? txtStkcode;
  String? txtDescription;
  String? datCreationdate;

  StockOptionModel({
    this.txtKey,
    this.txtStkcode,
    this.txtDescription,
    this.datCreationdate,
  });

  factory StockOptionModel.fromJson(Map<String, dynamic> json) {
    return StockOptionModel(
      txtKey: json['txtKey'],
      txtStkcode: json['txtStkcode'],
      txtDescription: json['txtDescription'],
      datCreationdate: json['datCreationdate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'txtKey': txtKey,
      'txtStkcode': txtStkcode,
      'txtDescription': txtDescription,
      'datCreationdate': datCreationdate,
    };
  }
}
