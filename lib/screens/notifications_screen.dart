import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  static const String routeName = '/notif';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => NotificationsScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
