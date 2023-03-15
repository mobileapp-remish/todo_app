import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/constants/common_constants.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/modules/dashboard/dashboard_screen.dart';
import 'package:todo_app/modules/login/login_screen.dart';
import 'package:todo_app/utils/helpers/preference_obj.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceObj.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Future.delayed(const Duration(seconds: 1));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: CommonConstants.appName,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: CommonConstants.regularFont,
        primarySwatch: Colors.blue,
      ),
      initialRoute: PreferenceObj.getIsLogin
          ? DashboardScreen.routeName
          : LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        DashboardScreen.routeName: (ctx) => const DashboardScreen(),
      },
    );
  }
}
