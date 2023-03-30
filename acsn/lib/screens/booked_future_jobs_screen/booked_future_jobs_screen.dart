import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/booked_future_jobs_screen_controller.dart';


class BookedFutureJobsScreen extends StatelessWidget {
  BookedFutureJobsScreen({Key? key}) : super(key: key);
  final bookedFutureJobsScreenController = Get.put(BookedFutureJobsScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
