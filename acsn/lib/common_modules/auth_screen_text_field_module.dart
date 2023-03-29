import 'package:acsn/constance/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthScreenTextFieldModule extends StatelessWidget {
  TextEditingController fieldController;
  String hintText;
  TextInputType keyboardType;
  FormFieldValidator? validate;
  int? maxLength;
  Widget? suffixIcon;
  bool? obscureText;

  AuthScreenTextFieldModule({
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
      decoration: InputDecoration(
        enabledBorder: inputBorder(),
        focusedBorder: inputBorder(),
        errorBorder: inputBorder(),
        focusedErrorBorder: inputBorder(),
        fillColor: AppColors.whiteColor,
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
