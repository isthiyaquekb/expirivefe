import 'dart:async';
import 'package:expirevefe/core/constant/app_keys.dart';
import 'package:expirevefe/core/constant/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
class SplashProvider extends ChangeNotifier{

  Timer? _timer;

  final storageBox=GetStorage();

  void startTimer(BuildContext context) {
    storageBox.writeIfNull(AppKeys.keyIsLoggedIn, false);
    _timer = Timer(const Duration(seconds: 3), navigateToHome(context));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  navigateToHome(BuildContext context) {
  storageBox.read(AppKeys.keyIsOnboardingStarted)?Navigator.of(context).pushReplacementNamed(AppRoutes.home):Navigator.of(context).pushReplacementNamed(AppRoutes.splash);
  }


}

