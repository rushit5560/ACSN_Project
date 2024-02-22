import 'package:acsn_app/constance/extension.dart';
import 'package:acsn_app/models/not_yet_booked_models/not_yet_booked_job_model.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constance/color.dart';
import '../models/common_model/job_details_model.dart';
import '../models/job_model.dart';
import '../utils/functions.dart';

class ListTileModule extends StatelessWidget {
  final String title;
  final String value;
  final bool iconShow;
  final Widget? leadingIcon;
  final Function()? onTap;
  JobDetails? jobModel;
  final bool onTapEnable;
  final bool copyStatus;

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
    this.copyStatus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backGroundColor,
                  ),
                ),
              ),
              Text(
                ":",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.backGroundColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: iconShow
              ? onTapEnable
                  ? GestureDetector(
                      onTap: jobModel!.changeSchedule == true ? onTap : () {},
                      child: RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            jobModel!.changeSchedule == true ? WidgetSpan(child: leadingIcon!) : const WidgetSpan(child: SizedBox()),
                            TextSpan(
                              text: " $value",
                              style: TextStyle(
                                fontSize: 10.sp,
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
                            style: TextStyle(
                              fontSize: 10.sp,
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
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.black,
                    // fontWeight: FontWeight.w500,
                  ),
                ),
        ),
        copyStatus ? GestureDetector(onTap: () async => await copyClipBoard(value), child: const Icon(Icons.copy_rounded)) : Container(),
      ],
    ).commonSymmetricPadding(vertical: 5);
  }
}

class ListTileExpandWiseModule extends StatelessWidget {
  final String title;
  final String value;

  const ListTileExpandWiseModule({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 25,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backGroundColor,
                  ),
                ),
              ),
              Text(
                ":",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.backGroundColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 75,
          child: Text(
            " $value",
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ).commonSymmetricPadding(vertical: 5);
  }
}
