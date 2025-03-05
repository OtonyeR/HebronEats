import 'package:HebronEats/config/app_router.dart';
import 'package:HebronEats/screens/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/theme.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hebron Eats',
      theme: theme(),
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      onGenerateRoute: AppRouter.onGenerateRoute,
      routes: {
        // StartScreen.id: (context) => StartScreen(),
        // Home.id: (context) => const Home(),
        HomePage.routeName: (context) => HomePage(),

        //FoodDetailScreen.id: (context) => FoodDetailScreen();
        //CartScreen.id: (context) => CartScreen();
      },
    );
  }
}
