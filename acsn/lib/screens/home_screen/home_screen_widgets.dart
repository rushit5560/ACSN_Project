import 'package:acsn/constance/color.dart';
import 'package:acsn/constance/extension.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class GridTileModule extends StatelessWidget {
  final String title;
  final String value;
  final Function() onTap;
  const GridTileModule({Key? key, required this.title, required this.value, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // color: AppColors.textGreenColor,
            border: Border.all(
              color: AppColors.buttonColor,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.backGroundColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // const SizedBox(height: 30),
              Text(
                value,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.backGroundColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ).commonAllSidePadding(10),
        ),
      ),
    );
  }
}

