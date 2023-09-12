
import 'package:flutter/material.dart';

import '../constance/color.dart';

PreferredSizeWidget customAppBar({
  required String titleText,

  bool leadingShow = true,
  Widget? leadingIcon,
  Function()? leadingOnTap,

  bool actionShow = true,
  Widget? actionIcon,
  Function()? actionOnTap,
}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: AppColors.backGroundColor,
    leading: leadingShow
        ? IconButton(
            onPressed: leadingOnTap,
            icon: leadingIcon!,
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
              icon: actionIcon!,
            )
          : Container(),
    ],
  );
}
