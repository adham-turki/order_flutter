import 'package:big_decimal/big_decimal.dart';

class RestProduct {
  String? txtCode;
  int? bolActive;
  int? bolBatchable;
  int? bolDonotprintprice;
  int? bolItemizable;
  int? bolLocal;
  int? bolPriceincludevat;
  BigDecimal? dblCostprice;
  BigDecimal? dblCurrentqty;
  double? dblDefaultvatrate;
  double? dblEqv;
  double? dblSellprice;
  double? dblSellprice2;
  double? dblSellprice3;
  double? dblSellprice4;
  int? intProducttype;
  int? intQuantitycontrols;
  String? txtBarcode;
  String? txtGroupCode;
  String? txtGroupreference;
  String? txtName;
  String? txtNotes;
  String? txtRetsalesacccode;
  String? txtSalesacccode;
  String? txtStkprodno;
  String? txtSupcode1;
  String? txtSupcode2;
  String? txtSupcode3;
  String? txtUnit;
  bool? adult;
  bool? ebt;
  bool? byWeight;
  String? itemSize;
  double? feeMultiplier;
  int? addToPos;
  String? color;
  String? taxCat;
  String? priorityIndex;
  int? smallLineModifier;
  int? showinMob;
  int? trackable;
  double? shipping;
  int? intLevel;
  String? txtParentCode;
  double? requestedTime;
  double? discountAmount;
  bool? percentDiscount;

  RestProduct({
    this.txtCode,
    this.bolActive,
    this.bolBatchable,
    this.bolDonotprintprice,
    this.bolItemizable,
    this.bolLocal,
    this.bolPriceincludevat,
    this.dblCostprice,
    this.dblCurrentqty,
    this.dblDefaultvatrate,
    this.dblEqv,
    this.dblSellprice,
    this.dblSellprice2,
    this.dblSellprice3,
    this.dblSellprice4,
    this.intProducttype,
    this.intQuantitycontrols,
    this.txtBarcode,
    this.txtGroupCode,
    this.txtGroupreference,
    this.txtName,
    this.txtNotes,
    this.txtRetsalesacccode,
    this.txtSalesacccode,
    this.txtStkprodno,
    this.txtSupcode1,
    this.txtSupcode2,
    this.txtSupcode3,
    this.txtUnit,
    this.adult,
    this.ebt,
    this.byWeight,
    this.itemSize,
    this.feeMultiplier,
    this.addToPos,
    this.color,
    this.taxCat,
    this.priorityIndex,
    this.smallLineModifier,
    this.showinMob,
    this.trackable,
    this.shipping,
    this.intLevel,
    this.txtParentCode,
    this.requestedTime,
    this.discountAmount,
    this.percentDiscount,
  });

  factory RestProduct.fromJson(Map<String, dynamic> json) {
    return RestProduct(
      txtCode: json['txtCode'],
      bolActive: json['bolActive'],
      bolBatchable: json['bolBatchable'],
      bolDonotprintprice: json['bolDonotprintprice'],
      bolItemizable: json['bolItemizable'],
      bolLocal: json['bolLocal'],
      bolPriceincludevat: json['bolPriceincludevat'],
      dblCostprice: json['dblCostprice'] != null
          ? BigDecimal.parse(json['dblCostprice'].toString())
          : null,
      dblCurrentqty: json['dblCurrentqty'] != null
          ? BigDecimal.parse(json['dblCurrentqty'].toString())
          : null,
      dblDefaultvatrate: json['dblDefaultvatrate'],
      dblEqv: json['dblEqv'],
      dblSellprice: json['dblSellprice'],
      dblSellprice2: json['dblSellprice2'],
      dblSellprice3: json['dblSellprice3'],
      dblSellprice4: json['dblSellprice4'],
      intProducttype: json['intProducttype'],
      intQuantitycontrols: json['intQuantitycontrols'],
      txtBarcode: json['txtBarcode'],
      txtGroupCode: json['txtGroupCode'],
      txtGroupreference: json['txtGroupreference'],
      txtName: json['txtName'],
      txtNotes: json['txtNotes'],
      txtRetsalesacccode: json['txtRetsalesacccode'],
      txtSalesacccode: json['txtSalesacccode'],
      txtStkprodno: json['txtStkprodno'],
      txtSupcode1: json['txtSupcode1'],
      txtSupcode2: json['txtSupcode2'],
      txtSupcode3: json['txtSupcode3'],
      txtUnit: json['txtUnit'],
      adult: (json['adult'] ?? "0") == "0" ? false : true,
      ebt: (json['ebt'] ?? "0") == "0" ? false : true,
      byWeight: (json['byWeight'] ?? "0") == "0" ? false : true,
      itemSize: json['itemSize'],
      feeMultiplier: json['feeMultiplier'],
      addToPos: json['addToPos'],
      color: json['color'],
      taxCat: json['taxCat'],
      priorityIndex: json['priorityIndex'],
      smallLineModifier: json['smallLineModifier'],
      showinMob: json['showinMob'],
      trackable: json['trackable'],
      shipping: json['shipping'],
      intLevel: json['intLevel'],
      txtParentCode: json['txtParentCode'],
      requestedTime: json['requestedTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'txtCode': txtCode,
      'bolActive': bolActive,
      'bolBatchable': bolBatchable,
      'bolDonotprintprice': bolDonotprintprice,
      'bolItemizable': bolItemizable,
      'bolLocal': bolLocal,
      'bolPriceincludevat': bolPriceincludevat,
      'dblCostprice': dblCostprice,
      'dblCurrentqty': dblCurrentqty,
      'dblDefaultvatrate': dblDefaultvatrate,
      'dblEqv': dblEqv,
      'dblSellprice': dblSellprice,
      'dblSellprice2': dblSellprice2,
      'dblSellprice3': dblSellprice3,
      'dblSellprice4': dblSellprice4,
      'intProducttype': intProducttype,
      'intQuantitycontrols': intQuantitycontrols,
      'txtBarcode': txtBarcode,
      'txtGroupCode': txtGroupCode,
      'txtGroupreference': txtGroupreference,
      'txtName': txtName,
      'txtNotes': txtNotes,
      'txtRetsalesacccode': txtRetsalesacccode,
      'txtSalesacccode': txtSalesacccode,
      'txtStkprodno': txtStkprodno,
      'txtSupcode1': txtSupcode1,
      'txtSupcode2': txtSupcode2,
      'txtSupcode3': txtSupcode3,
      'txtUnit': txtUnit,
      'adult': adult,
      'ebt': ebt,
      'byWeight': byWeight,
      'itemSize': itemSize,
      'feeMultiplier': feeMultiplier,
      'addToPos': addToPos,
      'color': color,
      'taxCat': taxCat,
      'priorityIndex': priorityIndex,
      'smallLineModifier': smallLineModifier,
      'showinMob': showinMob,
      'trackable': trackable,
      'shipping': shipping,
      'intLevel': intLevel,
      'txtParentCode': txtParentCode,
      'requestedTime': requestedTime,
    };
  }
}
