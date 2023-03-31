import 'dart:developer';
import 'package:acsn/common_modules/custom_submit_button.dart';
import 'package:acsn/constance/color.dart';
import 'package:acsn/constance/extension.dart';
import 'package:acsn/constance/message.dart';
import 'package:acsn/controller/not_yet_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../common_widgets/listtile_with_text_and_icon_module.dart';
import '../../common_widgets/listtile_with_textfield_module.dart';
import '../../models/job_model.dart';

class ListViewModule extends StatelessWidget {
  ListViewModule({super.key});
  final notYetScreenController = Get.find<NotYetScreenController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: notYetScreenController.jobList.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        JobModel singleItem = notYetScreenController.jobList[index];

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.scaffoldBackGroundColor,
            boxShadow: const [
              BoxShadow(
                blurRadius: 8,
                color: AppColors.greyColor,
                blurStyle: BlurStyle.outer,
              ),
            ],
          ),
          child: Column(
            children: [
              ListTileModule(title: AppMessage.job, value: "PhilBTestL2"),
              // ListTileModule(title: "Customer", value: "Client 1"),
              ListTileModule(title: AppMessage.name, value: "Test Site"),
              ListTileModule(
                  title: AppMessage.siteAddress, value: "27, Wall street, vic"),
              ListTileModule(title: AppMessage.paymentRefNo, value: "4"),
              ListTileModule(title: AppMessage.description, value: "Finished"),
              ListTileModule(title: AppMessage.client, value: "Lawn Mow"),
              ListTileModule(title: AppMessage.clientNotes, value: "Lawn Mow"),
              ListTileModule(title: AppMessage.status, value: "Lawn Mow"),
              ListTileModule(title: AppMessage.type, value: "Lawn Mow"),

              ListTileModule(
                title: AppMessage.date,
                value: notYetScreenController.date,
                iconShow: true,
                leadingIcon: const Icon(Icons.calendar_month_rounded, size: 19),
                onTap: () {
                  if (singleItem.changeSchedule == true) {
                    notYetScreenController.showDatePicker(context);
                  }
                },
                jobModel: singleItem,
                onTapEnable: true,
              ),

              ListTileModule(
                title: AppMessage.time,
                value: notYetScreenController.timeValue,
                iconShow: true,
                leadingIcon: const Icon(Icons.watch_later_outlined, size: 19),
                onTap: () {
                  if (singleItem.changeSchedule == true) {
                    notYetScreenController.showTimePicker(context);
                  }
                },
                jobModel: singleItem,
                onTapEnable: true,
              ),
              ListTileModule(
                title: AppMessage.phoneNumber,
                value: "9595-959-595",
                iconShow: true,
                leadingIcon: const Icon(Icons.phone, size: 19),
              ),
              ListTileModule(
                title: AppMessage.mobileNumber,
                value: "(98) 9555-5655",
                iconShow: true,
                leadingIcon:
                    const Icon(Icons.mobile_screen_share_outlined, size: 19),
              ),

              Row(
                children: [
                  Expanded(
                    child: CustomSubmitButtonModule(
                      labelText: AppMessage.changeSchedule,
                      onPress: () {
                        singleItem.changeSchedule = true;
                        log("changeSchedule : ${singleItem.changeSchedule}");
                        notYetScreenController.loadUI();
                      },
                      labelSize: 10.sp,
                    ).commonOnlyPadding(right: 5),
                  ),
                  Expanded(
                    child: singleItem.changeSchedule == true
                        ? CustomSubmitButtonModule(
                            labelText: AppMessage.save,
                            onPress: () {
                              singleItem.changeSchedule = false;
                              notYetScreenController.loadUI();
                            },
                            labelSize: 10.sp,
                          ).commonOnlyPadding(right: 50)
                        : Container(),
                  ),
                ],
              ),

              ListTileModuleWithTextField(
                title: AppMessage.workesnote,
                jobModel: singleItem,
                // fieldController: notYetScreenController.fieldWorkerNoteController,
              ),

              ListTileModuleWithTextField(
                title: AppMessage.internalNote,
                jobModel: singleItem,
                // fieldController: notYetScreenController.internalNoteController,
              ),

              CustomSubmitButtonModule(
                labelText: AppMessage.saveNotes,
                onPress: () {},
                labelSize: 12.sp,
              ).commonOnlyPadding(top: 10)
            ],
          ).commonAllSidePadding(10),
        ).commonAllSidePadding(15);
      },
    );
  }
}

class ListTileModuleWithModel extends StatelessWidget {
  final String title;
  final String value;
  final bool iconShow;
  final Widget? leadingIcon;
  final Function()? onTap;
  JobModel jobModel;

  // final Icon icon;

  ListTileModuleWithModel({
    Key? key,
    required this.title,
    required this.value,
    this.iconShow = false,
    this.leadingIcon,
    this.onTap,
    required this.jobModel,
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
              ? GestureDetector(
                  onTap: onTap,
                  child: RichText(
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
