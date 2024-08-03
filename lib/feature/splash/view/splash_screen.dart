import 'dart:async';
import 'package:expirevefe/core/constant/app_assets.dart';
import 'package:expirevefe/core/constant/app_colors.dart';
import 'package:expirevefe/core/constant/app_routes.dart';
import 'package:expirevefe/core/constant/app_string.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacementNamed(AppRoutes.onBoard));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const Image(image: AssetImage(AppAssets.appLogo),fit: BoxFit.contain,)
            ),
          ),
          const Text(AppString.appName,style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textColor
          ),)
        ],
      ),
    );
  }
}
