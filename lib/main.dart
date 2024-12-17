import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'controller/user_data_controller.dart';
import 'controller/app_user_controller.dart';
import 'controller/onboarding_controller.dart';
import 'controller/auth_controller.dart';
import 'controller/streak_controller.dart';
import 'controller/image_pick_contoller.dart';
import 'controller/bottom_nav_bar_controller.dart';

import 'model/app_style.dart';

import 'view/onboardings_creen.dart';
import 'view/shared/bottom_nav_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => UserDataController()..loadUserData()),
        ChangeNotifierProvider(create: (_) => AppUser()),
        ChangeNotifierProvider(create: (_) => OnboardingController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => ProfileImageController()),
        ChangeNotifierProvider(create: (_) => BottomNavBarController()),
        ChangeNotifierProvider(create: (_) => StreakContoller()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppStyles.blueColor, // Change to your app bar color
        statusBarIconBrightness: Brightness.light, // Set to light or dark
      ),
    );
    return MaterialApp(
      title: 'Rasseni',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppStyles.whiteColor,
        fontFamily: 'IBM Plex Sans',
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? OnboardingScreen()
          : BottomNavBar(),
    );
  }
}
