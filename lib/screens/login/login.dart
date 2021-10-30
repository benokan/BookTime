import 'package:book_time/common/global_snackbar.dart';
import 'package:book_time/screens/homepage/homepage.dart';
import 'package:book_time/screens/login/loginwidgets/clickable-text.dart';
import 'package:book_time/screens/login/loginwidgets/google-login.dart';
import 'package:book_time/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'loginwidgets/login-textfield-widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.all(0.1),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(0.1),
                  child: Image.asset(
                    "assets/logo-pref2.png",
                    width: 250,
                    height: 300,
                    alignment: Alignment.topCenter,
                  ),
                ),
                TextFormPaddingWidget(
                  emailController: emailController,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 60.0,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(
                        10.0), // changes the volume of the buttons...
                    decoration: boxDecorationLogin(),
                    child: PasswordTextFormLoginWidget(
                      passwordController: passwordController,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
                  child: GoogleLoginButton(),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 60.0),
                  child: Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 144, 92, 76),
                      ),
                      onPressed: () /* seems unnecessary async */ {
                        authService
                            .signInWithEmailAndPassword(
                                emailController.text, passwordController.text)
                            .then((value) {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        }).catchError((onError) {
                          GlobalSnackbar.showMessageUsingSnackBar(
                              Colors.red, onError.toString(), context);
                        });
                      },
                      child: Text("Login"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 60.0),
                      child: ClickableTextForgotPassword(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 0.0,
                        horizontal: 60.0,
                      ),
                      child: ClickableTextSignup(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
