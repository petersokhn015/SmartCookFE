import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/UserService/UserService.dart';
import '../Utils/Animation.dart';
import '../Utils/colors.dart';
import '../Utils/strings.dart';
import '../Widgets/CustomStepper.dart';
import '../Widgets/appButton.dart';
import '../Widgets/appInputField.dart';
import 'DietCuisines.dart';

class VerifyInformation extends StatefulWidget {
  const VerifyInformation({key});

  @override
  State<VerifyInformation> createState() => _VerifyInformationState();
}

class _VerifyInformationState extends State<VerifyInformation> {
  TextEditingController usernameController = TextEditingController();
  File _imageFile;
  String username;
  String email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prefsCreateInstance();
  }

  Future<void> prefsCreateInstance() async {
    final prefs = await SharedPreferences.getInstance();
    String u = await prefs.getString("username");
    String e = await prefs.getString("email");
    setState(() {
      username = u;
      email = e;
      usernameController.text = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserService service = UserService();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            StringSet.verifyInformationTitle,
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      StringSet.verifyInformationDescription,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                          ),
                          child: _imageFile != null
                              ? CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 150,
                                  backgroundImage: FileImage(_imageFile),
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 150,
                                  backgroundImage:
                                      AssetImage(ImageUrls.placeHolderURL),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    AppInputField(
                      text: StringSet.usernameText,
                      controller: usernameController,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    RichText(
                      text: TextSpan(
                          text: StringSet.byTappingText,
                          style: Theme.of(context).textTheme.labelMedium,
                          children: [
                            TextSpan(
                              text: "Terms of Use.",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: ColorSet.primaryColor),
                            )
                          ]),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 10),
                    AppButton(
                        text: StringSet.createAccountText,
                        onClicked: () async {
                          bool isSuccess = await service.updateUserInformation(
                              email, username, _imageFile, _imageFile.path);
                          if (isSuccess) {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      DietCuisines(),
                                  transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) =>
                                      SmartCookAnimation.PageRouteAnimation(
                                          animation, child),
                                ));
                          }
                        }),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    CustomStepper(numPage: 1),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
}
