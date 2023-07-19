import 'package:detecttestapppp/States/ThemeState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../Utils/colors.dart';

class GeneralSettings extends StatefulWidget {
  const GeneralSettings({Key key}) : super(key: key);

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeState>(
      builder: (context, themeState, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                "Choose a theme",
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? ColorSet.darkGrayColor
                        : ColorSet.darkWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: Theme.of(context).brightness == Brightness.light
                        ? ColorSet.darkGrayColor
                        : ColorSet.darkWhiteColor),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Customize the look and feel of your app by selecting your preferred theme.",
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? ColorSet.darkGrayColor
                            : ColorSet.darkWhiteColor),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: Text(
                      'Light Mode',
                      style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? ColorSet.darkGrayColor
                                  : ColorSet.darkWhiteColor),
                    ),
                    leading: Radio(
                      activeColor: ColorSet.primaryColor,
                      value: ThemeMode.light,
                      groupValue: themeState.themeMode,
                      onChanged: (value) {
                        themeState.setThemeMode(ThemeMode.light);
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? ColorSet.darkGrayColor
                                  : ColorSet.darkWhiteColor),
                    ),
                    leading: Radio(
                      activeColor: ColorSet.primaryColor,
                      value: ThemeMode.dark,
                      groupValue: themeState.themeMode,
                      onChanged: (value) {
                        themeState.setThemeMode(ThemeMode.dark);
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'System Preferences',
                      style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? ColorSet.darkGrayColor
                                  : ColorSet.darkWhiteColor),
                    ),
                    leading: Radio(
                      activeColor: ColorSet.primaryColor,
                      value: ThemeMode.system,
                      groupValue: themeState.themeMode,
                      onChanged: (value) {
                        themeState.setThemeMode(ThemeMode.system);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
