import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/job_model.dart';

class NotYetScreenController extends GetxController {
  RxBool isLoading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<JobModel> jobList = [
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

  TextEditingController searchTextEditingController = TextEditingController();
  // TextEditingController fieldWorkerNoteController = TextEditingController();
  // TextEditingController internalNoteController = TextEditingController();

  loadUI() {
    isLoading(true);
    isLoading(false);
  }
}
