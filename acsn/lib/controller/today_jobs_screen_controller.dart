import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/job_model.dart';

class TodayJobsScreenController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController searchTextEditingController = TextEditingController();

  List<JobModel> todayJobsList = [
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