// ignore_for_file: use_build_context_synchronously

import 'package:firebase_mvvm/model/models/task_model.dart';
import 'package:firebase_mvvm/view/widgets/main_progress.dart';
import 'package:firebase_mvvm/view/widgets/task_item.dart';
import 'package:firebase_mvvm/viewmodel/home_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeScreenViewmodel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_sharp),
            onPressed: () {
              viewModel.onExitPressed(context);
            },
          ),
        ],
      ),
      body: viewModel.isBusy
          ? const MainProgress()
          : viewModel.tasksList.isEmpty
              ? const Center(
                  child: Text(
                    "There is no tasks added yet,\n try add new one.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                )
              : ListView.builder(
                  itemCount: viewModel.tasksList.length,
                  itemBuilder: (context, index) {
                    TaskModel task = viewModel.tasksList[index];
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
                        viewModel.onDismissed(index);
                      },
                      child: TaskItem(
                        title: "${task.title}",
                        content: "${task.content}",
                        onTap: () async {
                          viewModel.onAddPressed(context: context, task: task);
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.onAddPressed(context: context);
        },
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
