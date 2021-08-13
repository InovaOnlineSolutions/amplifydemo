import 'dart:convert';

import 'package:flutter/material.dart';

import 'auth_credentials.dart';

import 'package:crypto/crypto.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback shouldShowLogin;

  final ValueChanged<SignUpCredentials> didProvideCredentials;

  SignUpPage({Key key, this.didProvideCredentials, this.shouldShowLogin})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 40),
          child: Stack(children: [
            // Sign Up Form
            _signUpForm(),

            // Login Button
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                  onPressed: widget.shouldShowLogin,
                  child: Text('Already have an account? Login.')),
            )
          ])),
    );
  }

  Widget _signUpForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username TextField
        TextField(
          controller: _usernameController,
          decoration:
              InputDecoration(icon: Icon(Icons.person), labelText: 'Username'),
        ),

        // Password TextField
        TextField(
          controller: _phoneController,
          decoration: InputDecoration(
              icon: Icon(Icons.phone), labelText: 'Phone'),
          keyboardType: TextInputType.numberWithOptions(decimal: false, signed: true),
        ),

        // Sign Up Button
        FlatButton(
            onPressed: _signUp,
            child: Text('Sign Up'),
            color: Theme.of(context).accentColor)
      ],
    );
  }

  void _signUp() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    //final password = _passwordController.text.trim();
    final phone = _phoneController.text.trim();


    print('username: $username');
    print('email: $email');
    print('phone: $phone');


    var password = _generatePassword(phonenumber: phone);

    print('Password ${password}');

    //Signing up with a default password
    final credentials = SignUpCredentials(
        username: username, password: password, phone: phone);

    widget.didProvideCredentials(credentials);
  }

  String _generatePassword({String phonenumber}){

    var seed1 = _getBase64String(phonenumber).toUpperCase();

    print('Seed 1 ${seed1}');

    var bytes = utf8.encode(DateTime. now(). millisecondsSinceEpoch.toString()); // data being hashed

    var digest = sha1.convert(bytes);

    var seed2 = digest.toString();

    print('Seed 2 ${seed2}');

    return seed1 + seed2 + '!';
  }

  //Generate a unique base 64 representation of the phone number as the username
  String _getBase64String(String phone){

    var bytes = utf8.encode(phone);
    var base64 = sha1.convert(bytes);


    return base64.toString();
  }
}
