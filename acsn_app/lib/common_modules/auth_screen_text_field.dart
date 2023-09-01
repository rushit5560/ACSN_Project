import 'package:flutter/material.dart';

import '../constance/color.dart';

// ignore: must_be_immutable
class TextFieldModule extends StatelessWidget {
  TextEditingController fieldController;
  String hintText;
  TextInputType keyboardType;
  FormFieldValidator? validate;
  int? maxLength;
  Widget? suffixIcon;
  bool? obscureText;

  TextFieldModule({
    Key? key,
    required this.fieldController,
    required this.hintText,
    required this.keyboardType,
    this.validate,
    this.maxLength,
    this.suffixIcon,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      validator: validate,
      obscureText: obscureText ?? false,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      maxLength: maxLength,
      cursorColor: AppColors.backGroundColor,
      decoration: InputDecoration(
        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(),
        errorBorder: inputBorder(),
        focusedErrorBorder: inputBorder(),
        fillColor: AppColors.scaffoldBackGroundColor,
        filled: true,
        hintText: hintText,
        errorMaxLines: 2,
        suffixIcon: suffixIcon,
        counterText: '',
        hintStyle: const TextStyle(color: AppColors.greyColor),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
      ),
    );
  }

  InputBorder inputBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.transparent),
    );
  }
}
