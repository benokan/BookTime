import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class ClickableTextSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an account? ',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            TextSpan(
                text: 'Sign up!',
                style: TextStyle(
                  color: Colors.blue,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Signup Text Clicked');
                    Navigator.pushNamed(context, '/signup');
                  }),
          ],
        ),
      ),
    );
  }
}

class ClickableTextForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: 'Forgot your password?',
              style: TextStyle(
                color: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Forgot you password Text Clicked');
                }),
        ]),
      ),
    );
  }
}
