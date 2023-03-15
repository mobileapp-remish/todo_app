import 'package:flutter/material.dart';

class CommonStyle {
  static InputDecoration getTextFormFiledDecorationForCreateNewTask({
    required String label,
    required String hintText,
    required IconData prefixIcon,
    String? prefixText,
    Widget? suffixWidget,
    Function? onSuffixIconClick,
  }) {
    InputDecoration inputDecoration;
    inputDecoration = InputDecoration(
      contentPadding: const EdgeInsets.only(
        top: 6.0,
        bottom: 6.0,
        left: 16.0,
      ),
      prefix: prefixText == null ? null : Text(prefixText),
      prefixIcon: Icon(prefixIcon),
      hintText: hintText,
      label: Text(
        label,
        style: const TextStyle(color: Colors.black),
      ),
      counterText: '',
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(color: Colors.red, width: 1.6),
      ),
      focusedBorder: const OutlineInputBorder(
        gapPadding: 2.0,
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(color: Colors.blue, width: 1.6),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(color: Colors.grey, width: 1.6),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        borderSide: BorderSide(color: Colors.red, width: 1.6),
      ),
      suffixIcon: suffixWidget ??
          const Padding(
            padding: EdgeInsets.all(14.0),
            child: SizedBox(
              height: 24.0,
              width: 24.0,
            ),
          ),
      border: InputBorder.none,
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
    );
    return inputDecoration;
  }
}
