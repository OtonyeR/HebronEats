import 'package:HebronEats/screens/basket_screen.dart';
import 'package:HebronEats/screens/checkout_screen.dart';
import 'package:HebronEats/screens/delivery_details_screen.dart';
import 'package:HebronEats/screens/food_details_screen.dart';
import 'package:HebronEats/screens/notifications_screen.dart';
import 'package:HebronEats/screens/order_history_screen.dart';
import 'package:HebronEats/screens/profile_screen.dart';
import 'package:HebronEats/screens/vendor_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:HebronEats/screens/homescreen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('The Route is: ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomePage.route();
      case HomePage.routeName:
        return HomePage.route();
      case BasketScreen.routeName:
        return CheckOutScreen.route();
      case CheckOutScreen.routeName:
        return DeliveryDetailScreen.route();
      case DeliveryDetailScreen.routeName:
        return BasketScreen.route();
      // case FoodDetailScreen.routeName:
      //   return FoodDetailScreen.route();
      case NotificationsScreen.routeName:
        return NotificationsScreen.route();
      case HistoryScreen.routeName:
        return HistoryScreen.route();
      // case EditBasketScreen.routeName:
      //   return EditBasketScreen.route();
      // case VendorScreen.routeName:
      //   return VendorScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
      settings: RouteSettings(name: '/error'),
    );
  }
}
