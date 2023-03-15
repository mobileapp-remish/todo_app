import 'package:flutter/material.dart';

AlertDialog alertDialogWidget({
  required String title,
  required String description,
  required String firstButtonName,
  required String secondButtonName,
  required VoidCallback onFirstButtonClicked,
  required VoidCallback onSecondButtonClicked,
}) {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(7.0),
      ),
    ),
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
    ),
    content: Text(
      description,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 14,
      ),
    ),
    actions: [
      TextButton(
        onPressed: onFirstButtonClicked,
        child: Text(
          firstButtonName,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      const SizedBox(
        width: 8.0,
      ),
      TextButton(
        onPressed: onSecondButtonClicked,
        child: Text(
          secondButtonName,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}
