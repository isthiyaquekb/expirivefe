import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:expirevefe/core/constant/app_assets.dart';
import 'package:expirevefe/core/constant/app_colors.dart';
import 'package:expirevefe/feature/home/viewmodel/home_viewmodel.dart';
import 'package:expirevefe/feature/inventory/view_model/inventory_view_model.dart';
import 'package:expirevefe/feature/scanner/view_model/scanner_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
// Access the HomeViewModel instance

    final homeProvider = Provider.of<HomeViewModel>(context, listen: false);
    final inventoryProvider = Provider.of<InventoryViewModel>(context, listen: false);
    homeProvider.checkForUpdate();
    homeProvider.getAllProductFromDB();

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                    "Keep an eye on these products, \nit's days are coming to an end",
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18)),
                InkWell(
                    onTap: () {

                    },
                    child: const Icon(Icons.notifications_active))
              ],
            ),
            Consumer<HomeViewModel>(
              builder: (context, dateProvider, child) => SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: EasyInfiniteDateTimeLine(
                    showTimelineHeader: false,
                    selectionMode: const SelectionMode.autoCenter(),
                    controller: dateProvider.easyDateController,
                    firstDate: DateTime.now(),
                    focusDate: dateProvider.focusDate,
                    lastDate: DateTime(2024, 12, 31),
                    activeColor: AppColors.primaryColor,
                    onDateChange: (selectedDate) {
                      dateProvider.setSelectedDate(selectedDate);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
                child: Consumer<HomeViewModel>(
              builder: (context, provider, child) => provider
                      .productFilteredList.isNotEmpty
                  ? ListView.builder(
                      itemCount: provider.productFilteredList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: AppColors.typeColor.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider
                                        .productFilteredList[index].productName,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textColor),
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                        const TextSpan(
                                            text: "Expiry Date:",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.textColor)),
                                        TextSpan(
                                            text: DateFormat('dd-MMM-yyyy').format(
                                                DateTime.parse(provider
                                                    .productFilteredList[index]
                                                    .expiryDate)),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textColor)),
                                      ])),
                                  RichText(
                                      text: TextSpan(children: [
                                        const TextSpan(
                                            text: "QTY:",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.textColor)),
                                        TextSpan(
                                            text: provider
                                                .productFilteredList[index].quantity
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textColor)),
                                      ])),
                                ],
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: provider
                                        .productFilteredList[index].daysLeft
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: provider
                                                    .productFilteredList[index]
                                                    .daysLeft <
                                                5
                                            ? AppColors.toxicColor
                                            : provider
                                                        .productFilteredList[
                                                            index]
                                                        .daysLeft <
                                                    30
                                                ? AppColors.mediumColor
                                                : AppColors.goodColor)),
                                const TextSpan(
                                    text: " days left",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textColor)),
                              ]))
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      child: Center(
                          child: Lottie.asset(AppAssets.notFoundLottie,
                              fit: BoxFit.contain)),
                    ),
            ))
          ],
        ),
      ),
      floatingActionButton: Consumer<ScannerViewModel>(
          builder: (context, provider, child) => FloatingActionButton(
              onPressed: () {
                inventoryProvider.nameController.clear();
                inventoryProvider.quantityController.clear();
                inventoryProvider.dateController.clear();
                inventoryProvider.barcodeController.clear();
                inventoryProvider.batchNoController.clear();
                provider.scanBarcodeNormal(context);
              },
              child: const Icon(Icons.qr_code_scanner_outlined))),
    );
  }
}
