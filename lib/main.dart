import 'package:camera/camera.dart';
import 'package:detecttestapppp/Screens/ARTest.dart';
import 'package:detecttestapppp/Screens/DietCuisines.dart';
import 'package:detecttestapppp/Screens/Home.dart';
import 'package:detecttestapppp/Screens/MyPreferences.dart';
import 'package:detecttestapppp/Screens/Profile.dart';
import 'package:detecttestapppp/Screens/RecipeDetailsPage.dart';
import 'package:detecttestapppp/Screens/VerifyInformation.dart';
import 'package:detecttestapppp/Utils/AppTheme.dart';
import 'package:detecttestapppp/Widgets/ARMo.dart';
import 'package:detecttestapppp/views/TestGifAR.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screens/ArAnimation.dart';
import 'Screens/Intolerances.dart';
import 'Screens/Login.dart';
import 'Screens/MainPage.dart';
import 'Screens/Search.dart';
import 'States/HomeState.dart';
import 'States/IngredientsProvider.dart';
import 'States/LoginState.dart';
import 'States/RecipeDetailsState.dart';
import 'States/SearchState.dart';
import 'States/SetPreferencesState.dart';
import 'States/SignUpState.dart';
import 'States/ThemeState.dart';
import 'States/UserState.dart';
import 'States/VerifyInformationState.dart';
import 'Utils/colors.dart';
import 'Widgets/IngredientsDetectionWidget.dart';
import 'views/homeView.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeState()),
        ChangeNotifierProvider(create: (context) => HomeState()),
        ChangeNotifierProvider(create: (context) => LoginState()),
        ChangeNotifierProvider(create: (context) => SignUpState()),
        ChangeNotifierProvider(create: (context) => SearchState()),
        ChangeNotifierProvider(create: (context) => SetPreferencesState()),
        ChangeNotifierProvider(create: (context) => UserState()),
        ChangeNotifierProvider(create: (context) => RecipeDetailsState()),
        ChangeNotifierProvider(create: (context) => VerifyInformationState()),
        ChangeNotifierProvider(create: (context) => IngredientsProvider()),
      ],
      child: Consumer<ThemeState>(
        builder: (context, themeState, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            themeMode: themeState.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: Login(),
          );
        },
      ),
    );
  }

  MaterialColor getMaterialColor(Color color) {
    final Map<int, Color> shades = {
      50: const Color.fromRGBO(202, 30, 85, .1),
      100: const Color.fromRGBO(202, 30, 85, .2),
      200: const Color.fromRGBO(202, 30, 85, .3),
      300: const Color.fromRGBO(202, 30, 85, .4),
      400: const Color.fromRGBO(202, 30, 85, .5),
      500: const Color.fromRGBO(202, 30, 85, .6),
      600: const Color.fromRGBO(202, 30, 85, .7),
      700: const Color.fromRGBO(202, 30, 85, .8),
      800: const Color.fromRGBO(202, 30, 85, .9),
      900: const Color.fromRGBO(202, 30, 85, 1),
    };
    return MaterialColor(color.value, shades);
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'views/homeView.dart';
// import 'views/testing.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//           textTheme:
//               GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme),
//           appBarTheme: AppBarTheme(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               centerTitle: true,
//               iconTheme: const IconThemeData(color: Colors.black),
//               titleTextStyle:
//                   GoogleFonts.nunito(color: Colors.black, fontSize: 20))),
//       home: const CircularStepperPage(),
//     );
//   }
// }
