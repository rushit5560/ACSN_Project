import 'package:acsn/constance/extension.dart';
import 'package:flutter/material.dart';

import '../constance/color.dart';
import '../models/job_model.dart';


class ListTileModuleWithTextField extends StatelessWidget {
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
}