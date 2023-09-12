
import 'package:acsn_app/screens/auth_screen/login_screen/login_screen.dart';
import 'package:acsn_app/screens/booked_future_jobs_screen/booked_future_jobs_screen.dart';
import 'package:acsn_app/screens/home_screen/home_screen.dart';
import 'package:acsn_app/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'constance/font_family.dart';
import 'screens/not_yet_booked_screen/not_yet_booked_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: FontFamilyText.roboto,
          ),
          home: LoginScreen(),
        );
      },
    );
  }
}
