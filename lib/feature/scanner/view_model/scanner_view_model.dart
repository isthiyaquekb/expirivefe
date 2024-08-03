
import 'package:expirevefe/feature/inventory/view_model/inventory_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/app_routes.dart';

class ScannerViewModel extends ChangeNotifier{
  String scanBarcode = 'Unknown';
  var selectedCategoryIndex=0;
  var selectedPopularIndex=0;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal(BuildContext context) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#6BC5D2', 'Cancel', true, ScanMode.BARCODE);
      print("BARCODE:$barcodeScanRes");
      if(context.mounted) context.read<InventoryViewModel>().setBarCode(barcodeScanRes);
      if(context.mounted) Navigator.pushNamed(context, AppRoutes.inventory);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    scanBarcode = barcodeScanRes;
    notifyListeners();
  }


}