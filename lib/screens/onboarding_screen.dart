import 'package:flutter/material.dart';
import 'package:twitch_clone/responsive/responsive.dart';
import 'package:twitch_clone/screens/login_screen.dart';
import 'package:twitch_clone/screens/signup_screen.dart';
import 'package:twitch_clone/widgets/custom_button.dart';

class OnBoardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';

  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to \nTwitch",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomButton(
                    text: "Log in",
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    }),
              ),
              CustomButton(
                  text: "Sign up",
                  onTap: () {
                    Navigator.pushNamed(context, SignupScreen.routeName);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
