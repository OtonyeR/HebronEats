import 'package:flutter/material.dart';

class DeliveryDetailScreen extends StatelessWidget {
  static const String routeName = '/delivery-details';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => DeliveryDetailScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  const DeliveryDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
