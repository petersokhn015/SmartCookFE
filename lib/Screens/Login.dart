//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/UserModel.dart';
import '../Models/UserPreferences.dart';
import '../Services/UserService/AuthenticationService.dart';
import '../Services/UserService/UserService.dart';
import '../States/LoginState.dart';
import '../States/UserState.dart';
import '../Utils/Animation.dart';
import '../Utils/colors.dart';
import '../Utils/strings.dart';
import '../Widgets/appButton.dart';
import '../Widgets/appInputField.dart';
import 'MainPage.dart';
import 'SignUp.dart';

class Login extends StatelessWidget {
  Login({key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthenticationService authService = AuthenticationService();
    UserService userService = UserService();
    final loginState = Provider.of<LoginState>(context, listen: true);
    final userState = Provider.of<UserState>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  StringSet.loginTitle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                Center(
                  child: Image.asset(
                    ImageUrls.loginURL,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                Column(
                  children: [
                    // AppGoogleButton(
                    //     text: StringSet.continueWithGoogleText,
                    //     onClicked: () async{
                    //
                    //     }),
                    // const SizedBox(height: 20.0),
                    // const OrWidget(),
                    // const SizedBox(height: 20.0),
                    AppInputField(
                      //onChanged: (email) => loginState.onEmailChanged(email),
                      text: StringSet.emailText,
                      controller: emailController,
                      isPassword: false,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (email) {
                        loginState.setIsEmailEmpty(email);
                        loginState.onEmailChanged(email);
                      },
                    ),
                    if (loginState.isEmailEmpty == false) ...[
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: loginState.isEmailValid
                                  ? Colors.green
                                  : Colors.transparent,
                              border: loginState.isEmailValid
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (!loginState.isEmailValid)
                            const Text("Invalid email")
                          else
                            const Text("Email is valid")
                        ],
                      ),
                    ],

                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    AppInputField(
                      text: StringSet.passwordText,
                      controller: passwordController,
                      isPassword: true,
                      onChanged: (password) {
                        loginState.setIsPasswordEmpty(password);
                        loginState.onPasswordChanged(password);
                      },
                    ),
                    if (loginState.isPasswordEmpty == false) ...[
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: loginState.isPasswordSixCharacters &&
                                      loginState.hasPasswordOneNumber &&
                                      loginState.hasPasswordOneLower &&
                                      loginState.hasPasswordOneSpecial &&
                                      loginState.isPasswordOneUpper
                                  ? Colors.green
                                  : Colors.transparent,
                              border: loginState.isPasswordSixCharacters &&
                                      loginState.hasPasswordOneNumber &&
                                      loginState.hasPasswordOneLower &&
                                      loginState.hasPasswordOneSpecial &&
                                      loginState.isPasswordOneUpper
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (!loginState.isPasswordSixCharacters)
                            const Text("Minimum 6 characters")
                          else if (!loginState.isPasswordOneUpper)
                            const Text("One Upper Case")
                          else if (!loginState.hasPasswordOneSpecial)
                            const Text("One Special Character")
                          else if (!loginState.hasPasswordOneLower)
                            const Text("One Lower Case")
                          else if (!loginState.hasPasswordOneNumber)
                            const Text("One Digit")
                          else
                            const Text("Password is valid")
                        ],
                      ),
                    ],

                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                  ],
                ),
                AppButton(
                    text: StringSet.loginTitle,
                    onClicked: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      bool isSuccess = await authService.login(
                          emailController.text, passwordController.text);

                      if (isSuccess) {
                        final user =
                            await userService.getUserInfo(emailController.text);
                        userState.setUserInformation(user);
                        await preferences.setString(
                            "email", emailController.text);
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      MainPage(),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  SmartCookAnimation.PageRouteAnimation(
                                      animation, child),
                            ));
                      }
                    }),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      StringSet.registerSwitchText,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      SignUp(),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  SmartCookAnimation.PageRouteAnimation(
                                      animation, child),
                            ));
                      },
                      child: const Text(
                        StringSet.signUpText,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorSet.primaryColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
