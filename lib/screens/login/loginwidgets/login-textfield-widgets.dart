import 'package:flutter/material.dart';

class PasswordTextFormLoginWidget extends StatelessWidget {
  const PasswordTextFormLoginWidget({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      cursorColor: Colors.brown,
      style: TextStyle(color: Colors.brown),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Colors.brown,
        ),
        hintText: 'Password',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.brown),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.brown, width: 3),
        ),
      ),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
    );
  }
}

class EmailTextFormLoginWidget extends StatelessWidget {
  const EmailTextFormLoginWidget({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      cursorColor: Colors.brown,
      style: TextStyle(color: Colors.brown),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email_outlined,
          color: Colors.brown,
        ),
        hintText: 'Email',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.brown,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.brown, width: 3),
        ),
      ),
      obscureText: false,
      enableSuggestions: true,
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your e-mail adress';
        }
        return null;
      },
    );
  }
}


BoxDecoration boxDecorationLogin() {
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

class TextFormPaddingWidget extends StatelessWidget {
  const TextFormPaddingWidget({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
      child: Container(
        padding: EdgeInsets.all(10.0), // changes the volume of the buttons...
        decoration: boxDecorationLogin(),
        child: Column(
          children: <Widget>[
            EmailTextFormLoginWidget(emailController: emailController),
          ],
        ),
      ),
    );
  }
}