import 'package:flutter/material.dart';

class GoogleSignUpButton extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      child: InkWell(
        onTap: () {
          print("Google sign up button clicked");
        },
        child: Ink(
          color: Colors.brown[50],
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Image.asset(
                  "assets/google-logo-g.png",
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: 10),
                Text(
                  'Sign up with Google',
                  style: TextStyle(
                    color: Colors.brown.shade900,
                    fontSize: 16,
                    height: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
