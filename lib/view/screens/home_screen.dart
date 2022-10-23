// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_mvvm/model/models/task_model.dart';
import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/model/services/auth_service.dart';
import 'package:firebase_mvvm/model/services/base/base_model.dart';
import 'package:firebase_mvvm/model/services/base/base_widget.dart';
import 'package:firebase_mvvm/model/services/firebase_auth_service.dart';
import 'package:firebase_mvvm/model/services/provider_setup.dart';
import 'package:firebase_mvvm/view/screens/add_task_screen.dart';
import 'package:firebase_mvvm/view/screens/splash_screen.dart';
import 'package:firebase_mvvm/view/widgets/components/main_progress.dart';
import 'package:firebase_mvvm/view/widgets/task_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeScreenModel>(
      initState: (model) => WidgetsBinding.instance.addPostFrameCallback((_) {
        model.readUser();
      }),
      model: HomeScreenModel(context: context),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Tasks List"),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout_sharp),
                onPressed: () async {
                  await FirebaseAuthService().signOut();
                  await AuthService().signOut();
                  AppHelper.pushReplaceAll(context, const SplashScreen());
                },
              ),
            ],
          ),
          body: model.busy
              ? const MainProgress()
              : ListView.builder(
                  itemCount: model.tasksList.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      title: "${model.tasksList[index].title}",
                      content: "${model.tasksList[index].content}",
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: model.onAddPressed,
            child: const Icon(Icons.add, size: 30),
          ),
        );
      },
    );
  }
}

class HomeScreenModel extends BaseModel {
  final BuildContext context;

  HomeScreenModel({required this.context});

  List<TaskModel> tasksList = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> readUser() async {
    try {
      setBusy();
      QuerySnapshot querySnapshot = await firestore.collection(auth.user?.uid ?? "Not_User").get();
      tasksList = querySnapshot.docs.map((e) => TaskModel.fromJson(e.data() as Map<String, dynamic>)).toList();
    } catch (error) {
      AppHelper.printt(error);
    }
    setIdle();
  }

  void onAddPressed() async {
    final res = await AppHelper.push(context, const AddTaskScreen());
    if (res == true) {
      readUser();
    }
  }
}
