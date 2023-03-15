import 'package:flutter/material.dart';
import 'package:todo_app/constants/images_path.dart';
import 'package:todo_app/modules/add_task/screens/add_task_screen.dart';
import 'package:todo_app/modules/login/login_screen.dart';
import 'package:todo_app/utils/helpers/preference_obj.dart';
import 'package:todo_app/utils/services/sign_in_with_google_service.dart';
import 'package:todo_app/utils/ui/app_dialogs.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          const SizedBox(
            height: 8.0,
          ),
          _createDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onClick: () => Navigator.of(context).pop(),
          ),
          const Divider(
            color: Colors.grey,
          ),
          _createDrawerItem(
            icon: Icons.add,
            text: 'Create New Task',
            onClick: () =>
                Navigator.of(context).pushNamed(AddTaskScreen.routeName),
          ),
          const Divider(
            color: Colors.grey,
          ),
          _createDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onClick: () {
              AppDialogs.showAlertDialog(
                context: context,
                title: 'Are you sure ?',
                description: 'Are you sure you want to logout ?',
                firstButtonName: 'No',
                secondButtonName: 'Yes',
                onFirstButtonClicked: () => Navigator.of(context).pop(),
                onSecondButtonClicked: () async {
                  Navigator.of(context).pop();
                  await SignInWithGoogleService.logoutWithGoogle();
                  await PreferenceObj.clearPreferenceDataAndLogout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName,
                    (Route route) => false,
                  );
                },
              );
            },
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return UserAccountsDrawerHeader(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            ImagesPath.drawerBackground, //PreferenceObj.getProfileUrl!,
          ),
        ),
      ),
      accountName: Text(
        PreferenceObj.getName!,
      ),
      accountEmail: Text(PreferenceObj.getEmailId!),
      currentAccountPictureSize: const Size.square(60.0),
      currentAccountPicture: CircleAvatar(
        radius: 12.0,
        child: Text(
          PreferenceObj.getName!.substring(0, 1).toUpperCase(),
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Widget _createHeader() {
  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required Function onClick,
  }) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 28.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              text,
            ),
          )
        ],
      ),
      onTap: () => onClick(),
    );
  }
}
