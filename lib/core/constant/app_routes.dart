
import 'package:expirevefe/feature/home/view/home_page.dart';
import 'package:expirevefe/feature/inventory/view/inventory_page.dart';
import 'package:expirevefe/feature/onboard/view/onboarding_screen.dart';
import 'package:expirevefe/feature/scanner/view/scanner_page.dart';
import 'package:expirevefe/feature/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static const splash = '/';
  static const onBoard = '/on-board';
  static const home = '/home';
  static const scanner = '/scanner';
  static const seeAll = '/see-all';
  static const search = '/search';
  static const permission = '/permission';
  static const inventory = '/inventory';


  static Route<dynamic> generatedRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case onBoard:
        return MaterialPageRoute(builder: (context) => const OnboardingScreen());

      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case scanner:
        return MaterialPageRoute(builder: (context) => const ScannerPage());
      case inventory:
        return MaterialPageRoute(builder: (context) => const InventoryPage());

      default:
        throw const FormatException("Route not found!, check routes again");
    }
  }
}
