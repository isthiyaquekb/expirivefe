import 'dart:developer';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:expirevefe/core/local_db/local_database.dart';
import 'package:expirevefe/core/services/local_notification_services.dart';
import 'package:expirevefe/feature/inventory/model/inventory_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends ChangeNotifier {
  var selectedCategoryIndex = 0;
  var selectedPopularIndex = 0;
  var dayLeft = 0;
  var productList = <InventoryModel>[];
  var productFilteredList = <InventoryModel>[];
  var easyDateController=EasyInfiniteDateTimelineController();
  var focusDate = DateTime.now();
  var pickedDate="";
  var dateFromDB="";

  List<InventoryModel> get getProductList => productList;

  void listenToNotification(){

  }
  void setCategory(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
  }

  void checkForUpdate(){
    InAppUpdate.checkForUpdate().then((info) {
      if(info.updateAvailability == UpdateAvailability.updateAvailable){
        updateMyApp();
      }
    });
  }

  void updateMyApp() async {
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((value) {
    }).catchError((e){
      e.toString();
      log("Exception Caught when updating app:${e.toString()}");
    });
  }
  void setSelectedDate(DateTime selectedDate){
    focusDate = selectedDate;
    pickedDate=DateFormat('dd-MMM-yyyy').format(
        selectedDate);
    productFilteredList = productList.where((o) => DateFormat('dd-MMM-yyyy').format(DateTime.parse(o.expiryDate)) == pickedDate).toList();
    notifyListeners();
  }

  //GET ALL PRODUCT FROM DB
  void getAllProductFromDB() async {
    var dataList = await LocalDatabase.queryAllProducts();
    productList.clear();
    for (var element in dataList!) {
      var data = InventoryModel.fromMap(element);
      calculateDaysRemaining(DateTime.parse(data.expiryDate), DateTime.now(),data);
    }
    if(dataList.isNotEmpty){
      if(DateTime.parse(InventoryModel.fromMap(dataList.first).expiryDate).isBefore(DateTime.now())){

        setSelectedDate(DateTime.now());
      }else{
        setSelectedDate(DateTime.parse(InventoryModel.fromMap(dataList.first).expiryDate));
      }
    }
    notifyListeners();
  }


  void calculateDaysRemaining(DateTime from, DateTime to, InventoryModel data,) {
    var fromDate = DateTime(from.year, from.month, from.day);
    var toDate = DateTime(to.year, to.month, to.day);
    dayLeft = (fromDate
        .difference(toDate)
        .inHours / 24).round();
    var inventoryData=InventoryModel(barcode: data.barcode,
        productName: data.productName,
        expiryDate: data.expiryDate,
        batchNo: data.batchNo,
        quantity: data.quantity,
        daysLeft: dayLeft);
    productList.add(inventoryData);
    var myDateTime=DateFormat("HH:mm").format(DateTime.parse(data.expiryDate
    ));
    LocalNotificationServices.showScheduleNotification(int.parse(myDateTime.split(":")[0]), int.parse(myDateTime.split(":")[1]), data.productName, data.expiryDate, data.daysLeft.toString());
  }


}