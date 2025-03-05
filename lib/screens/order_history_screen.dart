import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  static const String routeName = '/history';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => HistoryScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
