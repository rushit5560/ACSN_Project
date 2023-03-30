import 'package:acsn/constance/color.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({
  required String titleText,
  bool leadingShow = true,
  required Widget leadingIcon,
  required Function() leadingOnTap,
  bool actionShow = true,
  required Widget actionIcon,
  required Function() actionOnTap,
}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: AppColors.backGroundColor,
    leading: leadingShow
        ? IconButton(
            onPressed: leadingOnTap,
            icon: leadingIcon,
          )
        : null,
    title: Text(
      titleText,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    actions: [
      actionShow
          ? IconButton(
              onPressed: actionOnTap,
              icon: actionIcon,
            )
          : Container(),
    ],
  );
}
