
import 'package:acsn_app/constance/extension.dart';
import 'package:acsn_app/models/common_model/job_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_modules/custom_submit_button.dart';
import '../../constance/color.dart';
import '../../constance/message.dart';
import '../../controller/completed_job_screen_controller.dart';
import '../completed_job_details_screen/completed_job_details_screen.dart';

class JobAllListModule extends StatelessWidget {
  JobAllListModule({Key? key}) : super(key: key);
  final screenController = Get.find<CompletedJobScreenController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: screenController.completedJobList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {

        JobDetails singleItem = screenController.completedJobList[index];

        return Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: AppColors.scaffoldBackGroundColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.grey,
                  offset: Offset(0, 1),
                )
              ]),
          child: Column(
            children: [
              ListTileModule(
                title: AppMessage.customer,
                value: singleItem.clientName,
              ),
              ListTileModule(
                title: AppMessage.siteName,
                value: singleItem.siteName,
              ),
              ListTileModule(
                title: AppMessage.siteAddress,
                value: singleItem.siteAddress,
              ),
              ListTileModule(
                title: AppMessage.type,
                value: singleItem.jobType,
              ),
              ListTileModule(
                iconShow: true,
                leadingIcon: const Icon(Icons.date_range),
                title: AppMessage.date,
                value: singleItem.startDate,
              ),
              ListTileModule(
                iconShow: true,
                leadingIcon: const Icon(Icons.access_time_outlined),
                title: AppMessage.time,
                value: singleItem.startTime,
              ),
              ListTileModule(
                title: AppMessage.phoneNumber,
                value: singleItem.mobileNo,
              ),
              ListTileModule(
                title: AppMessage.mobileNumber,
                value: singleItem.phoneNo,
              ),
              CustomSubmitButtonModule(
                onPress: () => Get.to(() => CompletedJobDetailsScreen(),
                arguments: [singleItem.jobId.toString()]
                ),
                labelText: AppMessage.moreDetails,
              )
            ],
          ),
        );
      },
    );
  }
}

class ListTileModule extends StatelessWidget {
  final String title;
  final String value;
  final bool iconShow;
  final Widget? leadingIcon;

  // final Icon icon;

  const ListTileModule(
      {Key? key,
      required this.title,
      required this.value,
      this.iconShow = false,
      this.leadingIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              ? RichText(
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
                          fontWeight: FontWeight.w500,
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
