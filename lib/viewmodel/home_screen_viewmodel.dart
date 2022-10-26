// ignore_for_file: use_build_context_synchronously
import 'package:firebase_mvvm/model/models/task_model.dart';
import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/model/services/auth_service.dart';
import 'package:firebase_mvvm/model/services/fireauth_service.dart';
import 'package:firebase_mvvm/model/services/firestore_service.dart';
import 'package:firebase_mvvm/model/services/provider_setup.dart';
import 'package:firebase_mvvm/view/screens/add_task_screen.dart';
import 'package:firebase_mvvm/view/screens/splash_screen.dart';
import 'package:firebase_mvvm/view/widgets/approve_exit_dialog.dart';
import 'package:flutter/material.dart';

class HomeScreenViewmodel extends ChangeNotifier {
  HomeScreenViewmodel() {
    getAllTasks();
  }
  List<TaskModel> tasksList = [];
  bool isBusy = false;

  void onExitPressed(BuildContext context) async {
    final res = await showDialog(
      context: context,
      builder: (context) => ApproveExitDialog(context: context),
    );
    if (res == true) {
      await FireauthService.signOut();
      await AuthService().signOut();
      AppHelper.pushReplaceAll(context, const SplashScreen());
    }
  }

  void onAddPressed({required BuildContext context, TaskModel? task}) async {
    final res = await AppHelper.push(context, AddTaskScreen(task: task));
    if (res == true) {
      getAllTasks();
    }
  }

  Future<void> getAllTasks() async {
    try {
      isBusy = true;
      notifyListeners();
      final querySnapshot = await FirestoreService.getColData(collectionPath: auth.user?.uid ?? "Not_User");
      tasksList = querySnapshot.docs.map((e) => TaskModel.fromJson(e.data())).toList();
      AppHelper.printObject(tasksList);
    } catch (error) {
      AppHelper.printt(error);
    }
    isBusy = false;
    notifyListeners();
  }

  onDismissed(int index) async {
    try {
      AppHelper.printt(tasksList[index].title!);
      await deleteTask(tasksList[index].id!);
      tasksList.removeAt(index);
      notifyListeners();
    } catch (error) {
      AppHelper.printt(error);
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      isBusy = true;
      notifyListeners();
      FirestoreService.deleteDoc(collectionPath: auth.user?.uid ?? "Not_User", id: id);
    } catch (error) {
      AppHelper.printt(error);
    }
    isBusy = false;
    notifyListeners();
  }
}
