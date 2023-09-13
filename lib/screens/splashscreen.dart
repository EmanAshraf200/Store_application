import 'package:flutter/material.dart';
import 'package:store_app/screens/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login_Page()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/image1.jpg",
              height: 120,
              width: 120,
            ),
            Text(
              'LaZa',
              style: TextStyle(
                  fontSize: 35, color: Colors.black, fontFamily: 'Pacifico'),
            ),
          ],
        ),
      ),
    );
  }
}
