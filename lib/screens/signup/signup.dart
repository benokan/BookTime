import 'package:book_time/common/global_snackbar.dart';
import 'package:book_time/screens/homepage/homepage.dart';
import 'package:book_time/screens/signup/signupwidgets/signup-textfield-widgets.dart';
import 'package:book_time/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:book_time/screens/signup/signupwidgets/google-signup.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                "Sign Up Page",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[500],
                ),
              ),
              SizedBox(height: 40),
              Container(
                padding: EdgeInsets.all(
                    10.0), // changes the volume of the buttons...
                decoration: signupTextFieldDecoration(),
                child: EmailTextField(emailController: emailController),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(
                    10.0), // changes the volume of the buttons...
                decoration: signupTextFieldDecoration(),
                child: UsernameTextField(usernameController: usernameController),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(
                    10.0), // changes the volume of the buttons...
                decoration: signupTextFieldDecoration(),
                child: Column(
                  children: <Widget>[
                    PasswordTextFormWidget(passwordController: passwordController),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(
                    10.0), // changes the volume of the buttons...
                decoration: signupTextFieldDecoration(),
                child: Column(
                  children: <Widget>[
                    RepeatPasswordTextFormWidget(confirmPasswordController: confirmPasswordController),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                child: Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 144, 92, 76),
                    ),
                    onPressed: () async {
                      await authService
                          .createUserWithEmailAndPassword(
                              emailController.text, passwordController.text,usernameController.text)
                          .then((value) {
                          return Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                      ).catchError((onError) {
                          GlobalSnackbar.showMessageUsingSnackBar(
                              Colors.red, onError.toString(), context);
                        });;
                    },
                    child: Text('Sign Up'),
                  ),
                ),
                width: 185,
                height: 50,
              ),
              SizedBox(height: 20),
              Container(
                child: GoogleSignUpButton(),
                margin: EdgeInsets.only(top: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration signupTextFieldDecoration() {
    return BoxDecoration(
        color: Colors.brown[50],
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(
              4.0,
              4.0,
            ),
          ),
        ]);
  }
}
