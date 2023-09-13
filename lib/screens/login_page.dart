import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void showMySnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void Signin(String emailAddress, String password) async {
    islodaing = true;
    setState(() {});

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential.user!.uid);

      Navigator.pushNamed(context, 'HomePage');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showMySnackbar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showMySnackbar(context, 'Wrong password provided for that user.');
      }
    }
    islodaing = false;
    setState(() {});
  }

  String? email;
  String? password;
  bool islodaing = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: islodaing,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 850,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 4),
                  Center(
                    child: Container(
                      child: Image.asset(
                        "images/image1.jpg",
                        width: 300,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'LaZa',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                          fontFamily: 'Pacifico'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Signin(email!, password!);
                        }
                      },
                      child: Text(
                        'Sign In',
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff4c53a5),
                        onPrimary: Colors.white,
                        textStyle: TextStyle(fontSize: 20, color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don\'t have an account?',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'signup');
                          },
                          child: Text(
                            '  Sign Up',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ))
                    ],
                  ),
                  Spacer(flex: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
