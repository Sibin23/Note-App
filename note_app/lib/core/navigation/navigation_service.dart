import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  navigate(Widget rn,[ VoidCallback? voidCallback]) {
    navigationKey.currentState!
        .push(MaterialPageRoute(builder: (context) => rn)).then((value) {
          voidCallback!();
        },);
  }

  navigateUntil(Widget screen) {
    navigationKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => screen), (route) => false);
  }

  goBack() {
    return navigationKey.currentState!.pop();
  }
}
