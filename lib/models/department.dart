class DepartModel {
  String? txtCode;
  int? bolAllowdiscount;
  String? datCreationdate;
  int? intDeleted;
  String? txtNamea;
  String? txtNamee;
  String? txtPrintername;
  String? txtUsercode;
  int? numIsParent;
  String? txtParentCode;
  String? printTo;
  String? taxCategory;
  int? smalllinemodifier;
  int? addtopos;
  int? showinmob;
  String? color;
  String? priorityindex;
  String? age;
  int? express;
  int? ebt;
  int state = 0;
  String? kitchenKey;

  DepartModel(
      this.txtCode,
      this.bolAllowdiscount,
      this.datCreationdate,
      this.intDeleted,
      this.txtNamea,
      this.txtNamee,
      this.txtPrintername,
      this.txtUsercode,
      this.numIsParent,
      this.txtParentCode,
      this.printTo,
      this.taxCategory,
      this.smalllinemodifier,
      this.addtopos,
      this.showinmob,
      this.color,
      this.priorityindex,
      this.age,
      this.express,
      this.ebt,
      this.kitchenKey);

  DepartModel.fromJson(dynamic dep) {
    txtCode = dep['txtCode'];
    bolAllowdiscount = dep['bolAllowdiscount'];
    datCreationdate = dep['datCreationdate'].toString(); //
    intDeleted = dep['intDeleted'];
    txtNamea = dep['txtNamea'];
    txtNamee = dep['txtNamee'];
    txtPrintername = dep['txtPrintername'].toString();
    txtUsercode = dep['txtUsercode'].toString();
    numIsParent = dep['numIsParent'];
    txtParentCode = dep['txtParentCode'].toString();
    printTo = dep['printTo'].toString();
    taxCategory = dep['taxCategory'].toString();
    smalllinemodifier = dep['smalllinemodifier'];
    addtopos = dep['addtopos'];
    showinmob = dep['showinmob'];
    color = dep['color'].toString();
    priorityindex = dep['priorityindex'].toString();
    age = dep['age'].toString();
    express = dep['express'];
    ebt = dep['ebt'];
    kitchenKey = dep['kitchenKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dep = <String, dynamic>{};
    dep['txtCode'] = txtCode;
    dep['bolAllowdiscount'] = bolAllowdiscount;
    dep['datCreationdate'] = datCreationdate; //
    dep['intDeleted'] = intDeleted;
    dep['txtNamea'] = txtNamea;
    dep['txtNamee'] = txtNamee;
    dep['txtPrintername'] = txtPrintername;
    dep['txtUsercode'] = txtUsercode;
    dep['numIsParent'] = numIsParent;
    dep['txtParentCode'] = txtParentCode;
    dep['printTo'] = printTo;
    dep['taxCategory'] = taxCategory;
    dep['smalllinemodifier'] = smalllinemodifier;
    dep['addtopos'] = addtopos;
    dep['showinmob'] = showinmob;
    dep['color'] = color;
    dep['priorityindex'] = priorityindex;
    dep['age'] = age;
    dep['express'] = express;
    dep['ebt'] = ebt;
    dep['kitchenKey'] = kitchenKey;
    return dep;
  }

  @override
  String toString() {
    return txtNamea ?? txtNamee ?? "";
  }
}