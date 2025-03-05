import 'package:flutter/material.dart';

class CheckOutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => CheckOutScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
