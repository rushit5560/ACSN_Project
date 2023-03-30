import 'package:acsn/models/job_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookedFutureJobsScreenController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController searchTextEditingController = TextEditingController();

  List<JobModel> bookedFutureJobsList = [
    JobModel(
      changeSchedule: false,
      fieldWorkerNote: '',
      internalNote: '',
    ),
    JobModel(
      changeSchedule: false,
      fieldWorkerNote: '',
      internalNote: '',
    ),
    JobModel(
      changeSchedule: false,
      fieldWorkerNote: '',
      internalNote: '',
    ),
    JobModel(
      changeSchedule: false,
      fieldWorkerNote: '',
      internalNote: '',
    ),
    JobModel(
      changeSchedule: false,
      fieldWorkerNote: '',
      internalNote: '',
    ),
  ];

  loadUI() {
    isLoading(true);
    isLoading(false);
  }
}