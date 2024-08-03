class InventoryModel{
  final int barcode;
  final String productName;
  final String expiryDate;
  final String batchNo;
  final int quantity;
  final int daysLeft;

  InventoryModel({required this.barcode,required this.productName, required this.expiryDate,required this.batchNo,required this.quantity,required this.daysLeft});

  factory InventoryModel.fromMap(Map<String, dynamic> json) => InventoryModel(
    barcode: json["barcode_number"],
    productName: json["product_name"],
    expiryDate: json["expiry_date"],
    batchNo: json["batch_no"],
    quantity: json["quantity"],
    daysLeft: json["days_left"],
  );

  Map<String, dynamic> toMap() => {
    "barcode_number": barcode,
    "product_name": productName,
    "expiry_date": expiryDate,
    "batch_no": batchNo,
    "quantity": quantity,
    "days_left": daysLeft,
  };

}