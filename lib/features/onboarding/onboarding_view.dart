import 'package:flutter/material.dart';
import 'package:logbook_app_081/features/auth/login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int step = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Step: $step"),
            IconButton(
                onPressed: () {
                  setState(() {
                    step++;
                    if (step > 3) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()));
                    }
                  });
                },
                icon: Icon(Icons.plus_one))
          ],
        ),
      ),
    );
  }
}
