import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants/images_path.dart';
import 'package:todo_app/modules/dashboard/providers/task_provider.dart';
import 'package:todo_app/modules/dashboard/screens/dashboard_screen.dart';
import 'package:todo_app/utils/helpers/custom_exception.dart';
import 'package:todo_app/utils/helpers/preference_obj.dart';
import 'package:todo_app/utils/services/sign_in_with_google_service.dart';
import 'package:todo_app/utils/ui/app_dialogs.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/Login-Screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 7,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: Image.asset(
                      ImagesPath.loginBackground,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        ImagesPath.appLogo,
                        height: 100.0,
                        width: 100.0,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16.0,
                    left: 0.0,
                    right: 0.0,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'You must login via Google for\nauthentication.',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .fontSize,
                            letterSpacing: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    Expanded(
                      child: Wrap(
                        children: [
                          Card(
                            elevation: 3.0,
                            color: Colors.grey.shade50,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                _loginWithGoogle(context: context);
                              },
                              borderRadius: BorderRadius.circular(8.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 16.0,
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      ImagesPath.googleSymbol,
                                      height: 28.0,
                                      width: 28.0,
                                    ),
                                    const Expanded(
                                      child: Text(
                                        'Login With Google',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loginWithGoogle({required BuildContext context}) async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await SignInWithGoogleService.signInWithGoogle();
      await PreferenceObj.setUserId(userId: googleSignInAccount.id);
      await PreferenceObj.setName(name: googleSignInAccount.displayName ?? '');
      await PreferenceObj.setEmailId(emailId: googleSignInAccount.email);
      await PreferenceObj.setProfileUrl(
          profileUrl: googleSignInAccount.photoUrl ?? '');
      await PreferenceObj.setIsLogin(isLoggedIn: true);
      Provider.of<TaskProvider>(context, listen: false).initData();
      Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
      return;
    } on CustomException catch (errMsg) {
      await PreferenceObj.setIsLogin(isLoggedIn: false);
      AppDialogs.displayErrorSnackBar(
        message: errMsg.errMessage,
        context: context,
      );
    }
  }
}
