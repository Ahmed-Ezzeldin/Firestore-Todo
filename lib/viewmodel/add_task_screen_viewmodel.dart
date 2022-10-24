// ignore_for_file: use_build_context_synchronously
import 'package:firebase_mvvm/model/models/task_model.dart';
import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/model/services/base/base_model.dart';
import 'package:firebase_mvvm/model/services/firestore_service.dart';
import 'package:firebase_mvvm/model/services/provider_setup.dart';
import 'package:flutter/material.dart';

class AddTaskScreenViewmodel extends BaseModel {
  final BuildContext context;
  final TaskModel? task;
  AddTaskScreenViewmodel({required this.context, this.task}) {
    if (task != null) {
      titleController.text = task?.title ?? "";
      contentController.text = task?.content ?? "";
    }
  }

  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  Future<void> createTask() async {
    if (formKey.currentState!.validate()) {
      setBusy();
      AppHelper.unfocusFun(context);
      String currentTime = DateTime.now().toString();
      try {
        setBusy();
        FirestoreService.setData(collectionPath: auth.user?.uid ?? "Not_User", id: currentTime, data: {
          "id": currentTime,
          "title": titleController.text,
          "content": contentController.text,
          "createAt": currentTime.substring(0, 19),
          "updateAt": currentTime.substring(0, 19),
        });
        autovalidateMode = AutovalidateMode.disabled;
      } catch (error) {
        AppHelper.printt(error);
      }
      Navigator.of(context).pop(true);
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState();
    }
    setIdle();
  }

  Future<void> updateTask(String id) async {
    if (formKey.currentState!.validate()) {
      AppHelper.unfocusFun(context);
      String currentTime = DateTime.now().toString();
      try {
        setBusy();
        FirestoreService.updateData(collectionPath: auth.user?.uid ?? "Not_User", id: id, data: {
          "title": titleController.text,
          "content": contentController.text,
          "updateAt": currentTime.substring(0, 19),
        });
        autovalidateMode = AutovalidateMode.disabled;
      } catch (error) {
        AppHelper.printt(error);
      }
      Navigator.of(context).pop(true);
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState();
    }
  }
}
