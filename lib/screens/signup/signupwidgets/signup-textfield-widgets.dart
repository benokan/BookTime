import 'package:flutter/material.dart';

class RepeatPasswordTextFormWidget extends StatelessWidget {
  const RepeatPasswordTextFormWidget({
    Key? key,
    required this.confirmPasswordController,
  }) : super(key: key);

  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: confirmPasswordController,
      cursorColor: Colors.brown,
      style: TextStyle(color: Colors.brown),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock_outline,
          color: Colors.brown,
        ),
        hintText: 'Repeat Password',
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

class PasswordTextFormWidget extends StatelessWidget {
  const PasswordTextFormWidget({
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

class EmailTextField extends StatelessWidget {

  EmailTextField({required this.emailController});

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
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
        ),
      ],
    );
  }
}

class UsernameTextField extends StatelessWidget {

  UsernameTextField({required this.usernameController});

  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: usernameController,
          cursorColor: Colors.brown,
          style: TextStyle(color: Colors.brown),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_circle_outlined,
              color: Colors.brown,
            ),
            hintText: 'Name',
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
        ),
      ],
    );
  }
}
