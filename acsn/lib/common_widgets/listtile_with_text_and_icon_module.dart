import 'package:acsn/constance/extension.dart';
import 'package:flutter/material.dart';

import '../constance/color.dart';
import '../models/job_model.dart';


class ListTileModule extends StatelessWidget {
  final String title;
  final String value;
  final bool iconShow;
  final Widget? leadingIcon;
  final Function()? onTap;
  JobModel? jobModel;
  final bool onTapEnable;

  // final Icon icon;

  ListTileModule({
    Key? key,
    required this.title,
    required this.value,
    this.iconShow = false,
    this.leadingIcon,
    this.onTap,
    this.jobModel,
    this.onTapEnable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backGroundColor,
                  ),
                ),
              ),
              const Text(
                ":",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.backGroundColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: iconShow
              ? onTapEnable
              ? GestureDetector(
            onTap: jobModel!.changeSchedule == true ? onTap : () {},
            child: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  jobModel!.changeSchedule == true
                      ? WidgetSpan(child: leadingIcon!)
                      : const WidgetSpan(child: SizedBox()),
                  TextSpan(
                    text: " $value",
                    style: const TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          )
              : RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: " ",
              children: [
                WidgetSpan(child: leadingIcon!),
                TextSpan(
                  text: " $value",
                  style: const TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )
              : Text(
            " $value",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ).commonSymmetricPadding(vertical: 5);
  }
}