import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:store_app/screens/registration.dart';
import 'package:store_app/screens/splashscreen.dart';
import 'firebase_options.dart';
import 'package:store_app/models/cart_model.dart';
import 'package:store_app/models/favorite_model.dart';
import 'package:store_app/screens/home_page.dart';
import 'package:store_app/screens/producte_detailse.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedProductsModel()),
        ChangeNotifierProvider(
            create: (_) => FavoritesModel()), // Add this line
      ],
      child: StoreApp(),
    ),
  );
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        'HomePage': (context) => Home_Page(),
        'ProductDetails': (context) => ProductDetails(),
        'signup': (context) => Regestration_Page(),
        'SplashScreen': (context) => SplashScreen(),
      },
      initialRoute: 'SplashScreen',

      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
