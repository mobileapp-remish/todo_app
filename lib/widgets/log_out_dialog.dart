import 'package:flutter/material.dart';

AlertDialog logOutDialog({
  required VoidCallback onCancelBtnClick,
  required VoidCallback onLogoutBtnClick,
}) {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          7.0,
        ),
      ),
    ),
    content: const Text(
      "Are You Sure You Want To Logout ?",
      style: const TextStyle(
        color: Colors.black87,
      ),
    ),
    actions: [
      TextButton(
        onPressed: onCancelBtnClick,
        child: const Text(
          "Cancel",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const SizedBox(width: 8.0,),
      TextButton(
        onPressed: onLogoutBtnClick,
        child: const Text(
          "Logout",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}
