import 'package:flutter/material.dart';

AlertDialog informationWidget({
  required String title,
  required String description,
  required String actionName,
  required VoidCallback onClickAction,
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
        onPressed: onClickAction,
        child: Text(
          actionName,
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
