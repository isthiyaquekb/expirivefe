
import 'package:expirevefe/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Center(
          child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: double.maxFinite,
        color: Colors.amber.shade200,

      )),
    );
  }
}
