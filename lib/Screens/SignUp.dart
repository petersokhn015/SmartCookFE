import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/UserService/AuthenticationService.dart';
import '../States/SignUpState.dart';
import '../Utils/Animation.dart';
import '../Utils/colors.dart';
import '../Utils/strings.dart';
import '../Widgets/CustomStepper.dart';
import '../Widgets/appButton.dart';
import '../Widgets/appInputField.dart';
import 'Login.dart';
import 'VerifyInformation.dart';

class SignUp extends StatelessWidget {
  SignUp({key});
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationService service = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    final signUpState = Provider.of<SignUpState>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            StringSet.createAccountTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                Center(
                  child: Image.asset(
                    ImageUrls.registerURL,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                AppInputField(
                  onChanged: (username) {
                    signUpState.setIsUsernameEmpty(username);
                    signUpState.onUsernameChanged(username);
                  },
                  text: StringSet.usernameText,
                  controller: usernameController,
                  isPassword: false,
                ),
                if (signUpState.isUsernameEmpty == false) ...[
                  Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: signUpState.isUsernameValid
                              ? Colors.green
                              : Colors.transparent,
                          border: signUpState.isUsernameValid
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
                      if (!signUpState.isUsernameValid)
                        const Text("Invalid username")
                      else
                        const Text("Username is valid")
                    ],
                  ),
                ],
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                AppInputField(
                  onChanged: (email) {
                    signUpState.setIsEmailEmpty(email);
                    signUpState.onEmailChanged(email);
                  },
                  text: StringSet.emailText,
                  controller: emailController,
                  isPassword: false,
                  keyboardType: TextInputType.emailAddress,
                ),
                if (signUpState.isEmailEmpty == false) ...[
                  Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: signUpState.isEmailValid
                              ? Colors.green
                              : Colors.transparent,
                          border: signUpState.isEmailValid
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
                      if (!signUpState.isEmailValid)
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
                  onChanged: (password) {
                    signUpState.setIsPasswordEmpty(password);
                    signUpState.onPasswordChanged(password);
                  },
                  text: StringSet.passwordText,
                  controller: passwordController,
                  isPassword: true,
                ),
                if (signUpState.isPasswordEmpty == false) ...[
                  Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: signUpState.isPasswordSixCharacters &&
                                  signUpState.hasPasswordOneNumber &&
                                  signUpState.hasPasswordOneLower &&
                                  signUpState.hasPasswordOneSpecial &&
                                  signUpState.isPasswordOneUpper
                              ? Colors.green
                              : Colors.transparent,
                          border: signUpState.isPasswordSixCharacters &&
                                  signUpState.hasPasswordOneNumber &&
                                  signUpState.hasPasswordOneLower &&
                                  signUpState.hasPasswordOneSpecial &&
                                  signUpState.isPasswordOneUpper
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
                      if (!signUpState.isPasswordSixCharacters)
                        const Text("Minimum 6 characters")
                      else if (!signUpState.isPasswordOneUpper)
                        const Text("One Upper Case")
                      else if (!signUpState.hasPasswordOneSpecial)
                        const Text("One Special Character")
                      else if (!signUpState.hasPasswordOneLower)
                        const Text("One Lower Case")
                      else if (!signUpState.hasPasswordOneNumber)
                        const Text("One Digit")
                      else
                        const Text("Pasword is valid")
                    ],
                  ),
                ],
                SizedBox(
                  height: MediaQuery.of(context).size.height / 50,
                ),
                AppButton(
                    text: StringSet.continueText,
                    onClicked: () async {
                      bool isRegistered = await service.register(
                          usernameController.text,
                          emailController.text,
                          passwordController.text);

                      // bool isRegistered = true;
                      if (isRegistered) {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setString(
                            'username', usernameController.text);
                        preferences.setString('email', emailController.text);
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      VerifyInformation(),
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
                      StringSet.loginSwitchText,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      Login(),
                              transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) =>
                                  SmartCookAnimation.PageRouteAnimation(
                                      animation, child),
                            ));
                      },
                      child: const Text(
                        StringSet.loginTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorSet.primaryColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomStepper(numPage: 0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
