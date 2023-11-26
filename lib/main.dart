import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/providers/user_provider.dart';
import 'package:twitch_clone/resources/auth_methods.dart';
import 'package:twitch_clone/screens/home_screen.dart';
import 'package:twitch_clone/screens/login_screen.dart';
import 'package:twitch_clone/screens/onboarding_screen.dart';
import 'package:twitch_clone/screens/signup_screen.dart';
import 'package:twitch_clone/utils/colors.dart';
import 'package:twitch_clone/models/user.dart' as model;
import 'package:twitch_clone/widgets/loading_indicator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD7saK9Z2wu4LzbgOkRx3St5GUNGShirPo",
            authDomain: "twitch-clone-25259.firebaseapp.com",
            projectId: "twitch-clone-25259",
            storageBucket: "twitch-clone-25259.appspot.com",
            messagingSenderId: "725344960075",
            appId: "1:725344960075:web:e01aaa8f215d7ef54d57ce"));
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBfC5hOCulj7L-kwzLG9txb5d2bVnOVeKk",
            appId: "1:725344960075:android:94a0660a13f71d7b4d57ce",
            messagingSenderId: "725344960075",
            projectId: "twitch-clone-25259",
            storageBucket: "twitch-clone-25259.appspot.com"));
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twitch Clone',
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: AppBarTheme.of(context).copyWith(
              backgroundColor: backgroundColor,
              elevation: 0,
              titleTextStyle: const TextStyle(
                color: primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              iconTheme: const IconThemeData(
                color: primaryColor,
              ))),
      routes: {
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
      home: FutureBuilder(
          future: AuthMethods()
              .getCurrentUser(FirebaseAuth.instance.currentUser != null
                  ? FirebaseAuth.instance.currentUser!.uid
                  : null)
              .then((value) {
            if (value != null) {
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(model.User.fromMap(value));
            }
            return value;
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingIndicator();
            }

            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const OnBoardingScreen();
          }),
    );
  }
}
