import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_amplify_1_22_6/sign_up_page.dart';
import 'package:flutter_amplify_1_22_6/verification_page.dart';
import 'amplifyconfiguration.dart';
import 'auth_service.dart';
import 'login_page.dart';


import 'datascreen.dart';
import 'login_verification_page.dart';


void main() {
  runApp(AmplifyApp());
}

class AmplifyApp extends StatefulWidget {
  @override
  _AmplifyAppState createState() => _AmplifyAppState();
}

class _AmplifyAppState extends State<AmplifyApp> {

  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _configureAmplify();
    _authService.checkAuthStatus();
    _authService.showLogin();
  }


  void _configureAmplify() async {
    Amplify.addPlugin(AmplifyAuthCognito());

    try {
      await Amplify.configure(infiniteamplifydevconfig);

      print('Successfully configured Amplify 🎉');
    } catch (e) {
      print('Could not configure Amplify ☠️');
    }
  }




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Click N Collect',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginPage.id,
      home: StreamBuilder<AuthState>(
        stream: _authService.authStateController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Navigator(
              pages: [
                // 4
                // Show Login Page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                  MaterialPage(
                      child: LoginPage(
                          didProvideCredentials:
                          _authService.loginWithCredentials,
                          shouldShowSignUp: _authService.showSignUp)),

                // 5
                // Show Sign Up Page
                if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                  MaterialPage(
                      child: SignUpPage(
                          didProvideCredentials:
                          _authService.signUpWithCredentials,
                          shouldShowLogin: _authService.showLogin)),

                if (snapshot.data.authFlowStatus == AuthFlowStatus.verification)
                  MaterialPage(
                      child: VerificationPage(
                          didProvideVerificationCode: _authService.verifyCode)),

                if (snapshot.data.authFlowStatus == AuthFlowStatus.authOTP)
                  MaterialPage(
                      child: LoginVerificationPage(
                          didProvideVerificationCode: _authService.verifyLoginOTP)),


                if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
                  MaterialPage(
                      child: DataScreen(
                        dologOut: _authService.logOut,
                      ))
              ],
              onPopPage: (route, result) => route.didPop(result),
            );
          } else {
            // 6
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

}