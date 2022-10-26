// ignore_for_file: use_build_context_synchronously
import 'package:firebase_mvvm/model/models/task_model.dart';
import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/model/services/firestore_service.dart';
import 'package:firebase_mvvm/model/services/provider_setup.dart';
import 'package:flutter/material.dart';

class AddTaskScreenViewmodel extends ChangeNotifier {
  AddTaskScreenViewmodel();

  bool isBusy = false;
  TaskModel? task;

  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void setTaskValues(TaskModel? taskModel) {
    titleController.text = taskModel?.title ?? "";
    contentController.text = taskModel?.content ?? "";
    // notifyListeners();
  }

  Future<void> createTask(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      AppHelper.unfocusFun(context);
      String currentTime = DateTime.now().toString();
      try {
        isBusy = true;
        notifyListeners();
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
      isBusy = false;
      notifyListeners();
      Navigator.of(context).pop(true);
    } else {
      autovalidateMode = AutovalidateMode.always;
    }
    notifyListeners();
  }

  Future<void> updateTask(BuildContext context, String id) async {
    if (formKey.currentState!.validate()) {
      AppHelper.unfocusFun(context);
      String currentTime = DateTime.now().toString();
      try {
        isBusy = true;
        notifyListeners();
        FirestoreService.updateData(collectionPath: auth.user?.uid ?? "Not_User", id: id, data: {
          "title": titleController.text,
          "content": contentController.text,
          "updateAt": currentTime.substring(0, 19),
        });
        autovalidateMode = AutovalidateMode.disabled;
      } catch (error) {
        AppHelper.printt(error);
      }
      isBusy = false;
      notifyListeners();
      Navigator.of(context).pop(true);
    } else {
      autovalidateMode = AutovalidateMode.always;
      notifyListeners();
    }
  }
}
