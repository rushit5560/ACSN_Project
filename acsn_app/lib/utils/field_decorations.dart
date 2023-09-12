

import 'package:flutter/material.dart';

import '../constance/color.dart';

InputDecoration fieldDecorations({Color fillColor = AppColors.whiteColor}) {
  return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      fillColor: fillColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8)
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8)
      ),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8)
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8)
      )
  );
}


InputBorder inputBorder() {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.transparent),
  );
}