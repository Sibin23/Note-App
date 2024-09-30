import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigationKey;

  static NavigationService instance = NavigationService();

  NavigationService() {
    navigationKey = GlobalKey<NavigatorState>();
  }

  navigate(Widget rn, [VoidCallback? voidCallback]) {
    navigationKey.currentState!
        .push(MaterialPageRoute(builder: (context) => rn))
        .then(
      (value) {
        voidCallback!();
      },
    );
  }

  navigateUntil(Widget screen, [VoidCallback? voidCallback]) {
    navigationKey.currentState!
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => screen), (route) => false)
        .then((value) {
      voidCallback!();
    });
  }

  goBack() {
    navigationKey.currentState!.pop();
  }
}
