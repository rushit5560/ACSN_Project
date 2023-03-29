import 'package:acsn/constance/color.dart';
import 'package:acsn/constance/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common_modules/custom_submit_button.dart';

class JobAllListModule extends StatelessWidget {
  const JobAllListModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(12),
          margin:const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: AppColors.scaffoldBackGroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: Colors.grey,
                offset: Offset(0, 1),
              )
            ]
          ),
          child: Column(
            children:  [
              const ListTileModule(
                title: 'Customer',
                value: 'Client 1',
              ),
              const ListTileModule(
                title: 'Site Name',
                value: 'test site',
              ),
              const ListTileModule(
                title: 'Site Address',
                value: '27, wall street, vic ',
              ),
              const ListTileModule(
                title: 'Type',
                value: 'Lawn Mow',
              ),
              const ListTileModule(
                iconShow: true,
                leadingIcon: Icon(Icons.date_range),
                title: 'Date',
                value: '25/02/2023 ',
              ),
              const ListTileModule(
                iconShow: true,
                leadingIcon: Icon(Icons.access_time_outlined),
                title: 'Time',
                value: '02:30 PM',
              ),
              const ListTileModule(
                title: 'Phone Number',
                value: '9595-959-595',
              ),
              const ListTileModule(
                title: 'Mobile Number',
                value: '(98) 9555-5655',
              ),
              CustomSubmitButtonModule(
                onPress: () { },
                labelText: 'More Details',)
            ],
          ),
        );
      },
      ),
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
                  style:  const TextStyle(
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
