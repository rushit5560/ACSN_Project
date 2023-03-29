import 'package:acsn/constance/extension.dart';
import 'package:flutter/material.dart';

class ListTileModule extends StatelessWidget {
  const ListTileModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Expanded(
            child: Text(
              'Not Yet Booked',
              style: TextStyle(),
            ),
          ),

          Text(
            '5',
            style: TextStyle(),
          ),
        ],
      ).commonSymmetricPadding(horizontal: 10, vertical: 12),
    );
  }
}
