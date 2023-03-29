import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotYetScreenController extends GetxController {
  RxBool isLoading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController searchTextEditingController = TextEditingController();
}
