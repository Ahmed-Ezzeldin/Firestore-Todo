// ignore_for_file: use_build_context_synchronously

import 'package:firebase_mvvm/model/models/task_model.dart';
import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/model/services/auth_service.dart';
import 'package:firebase_mvvm/model/services/base/base_widget.dart';
import 'package:firebase_mvvm/model/services/firebase_auth_service.dart';
import 'package:firebase_mvvm/view/screens/splash_screen.dart';
import 'package:firebase_mvvm/view/widgets/main_progress.dart';
import 'package:firebase_mvvm/view/widgets/task_item.dart';
import 'package:firebase_mvvm/viewmodel/home_screen_viewmodel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeScreenViewmodel>(
      initState: (model) => WidgetsBinding.instance.addPostFrameCallback((_) {
        model.getAllTasks();
      }),
      model: HomeScreenViewmodel(context: context),
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
                    TaskModel task = model.tasksList[index];
                    return Dismissible(
                      key: Key(task.id!),
                      background: const SizedBox(),
                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.delete,
                          size: 35,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) {
                        model.onDismissed(index);
                      },
                      child: TaskItem(
                        title: "${task.title}",
                        content: "${task.content}",
                        onTap: () async {
                          model.onAddPressed(task: task);
                        },
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              model.onAddPressed();
            },
            child: const Icon(Icons.add, size: 30),
          ),
        );
      },
    );
  }
}