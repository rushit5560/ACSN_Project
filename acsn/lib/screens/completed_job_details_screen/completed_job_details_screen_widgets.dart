import 'package:acsn/constance/color.dart';
import 'package:acsn/constance/extension.dart';
import 'package:flutter/material.dart';

import '../../models/job_model.dart';

/*class ListTileModule extends StatelessWidget {
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
}*/

class DrawerModule extends StatelessWidget {
  const DrawerModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(3),
            height: 50,
            color: AppColors.backGroundColor,
            child: const Text('Menu'),
          ),
          const ListTile(
            leading: Icon(Icons.home,color:AppColors.backGroundColor),
            title: Text('Home',style: TextStyle(color: Colors.white)),
          ),
          const Divider(
            color: Colors.white,
          ),
          const ListTile(
            leading: Icon(Icons.home,color:AppColors.backGroundColor),
            title: Text('Home',style: TextStyle(color: Colors.white)),
          ),
          const Divider(
            color: Colors.white,
          ),
          const ListTile(
            leading: Icon(Icons.home,color:AppColors.backGroundColor),
            title: Text('Home',style: TextStyle(color: Colors.white)),
          ),
          const Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

/*class ListTileModuleWithTextField extends StatelessWidget {
  final String title;
  JobModel jobModel;
  // TextEditingController fieldController;
  // final String value;
  // final bool iconShow;
  // final Widget? leadingIcon;

  // final Icon icon;

  ListTileModuleWithTextField(
      {Key? key,
        required this.title,
        required this.jobModel,
        // required this.fieldController,
        // required this.value,
        // this.iconShow = false,
        // this.leadingIcon,
      })
      : super(key: key);

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
                ": ",
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
          child: TextFormField(
            // controller: fieldController,
            onChanged: (value) {
              jobModel.fieldWorkerNote = value;
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                fillColor: AppColors.whiteColor,
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
            ),
          ),
        ),
      ],
    ).commonSymmetricPadding(vertical: 5);
  }
}*/
