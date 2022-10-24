import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_mvvm/model/models/task_model.dart';
import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/model/services/base/base_model.dart';
import 'package:firebase_mvvm/model/services/provider_setup.dart';
import 'package:firebase_mvvm/view/screens/add_task_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenViewmodel extends BaseModel {
  final BuildContext context;
  HomeScreenViewmodel({required this.context});

  List<TaskModel> tasksList = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void onAddPressed({TaskModel? task}) async {
    final res = await AppHelper.push(context, AddTaskScreen(task: task));
    if (res == true) {
      getAllTasks();
    }
  }

  Future<void> getAllTasks() async {
    try {
      setBusy();
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestore.collection(auth.user?.uid ?? "Not_User").get();
      tasksList = querySnapshot.docs.map((e) => TaskModel.fromJson(e.data())).toList();
      // AppHelper.printObject(tasksList);
      AppHelper.printObject(tasksList);
    } catch (error) {
      AppHelper.printt(error);
    }
    setIdle();
  }

  onDismissed(int index) async {
    try {
      AppHelper.printt(tasksList[index].title!);
      await deleteTask(tasksList[index].id!);
      tasksList.removeAt(index);
      setState();
    } catch (error) {
      AppHelper.printt(error);
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      setBusy();
      await firestore.collection(auth.user?.uid ?? "Not_User").doc(id).delete();
    } catch (error) {
      AppHelper.printt(error);
    }
    setIdle();
  }
}
