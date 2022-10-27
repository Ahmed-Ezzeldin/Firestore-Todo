import 'package:firebase_mvvm/model/models/task_model.dart';
import 'package:firebase_mvvm/model/services/base/base_widget.dart';
import 'package:firebase_mvvm/view/widgets/main_textfield.dart';
import 'package:firebase_mvvm/view/widgets/main_button.dart';
import 'package:firebase_mvvm/view/widgets/main_progress.dart';
import 'package:firebase_mvvm/viewmodel/add_task_screen_viewmodel.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    this.task,
    Key? key,
  }) : super(key: key);

  final TaskModel? task;

  @override
  Widget build(BuildContext context) {
    final Size mediaSize = MediaQuery.of(context).size;
    return BaseWidget<AddTaskScreenViewmodel>(
      model: AddTaskScreenViewmodel(context: context, task: task),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: task == null ? const Text("Add Task Screen") : const Text("Update Task Screen"),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Form(
                key: model.formKey,
                autovalidateMode: model.autovalidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainTextField(
                      controller: model.titleController,
                      validator: Validator.required,
                      borderRadius: 5,
                      borderWidth: 0.0001,
                      isFilled: true,
                      hint: "Title",
                      textStyle: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    MainTextField(
                      controller: model.contentController,
                      validator: Validator.required,
                      borderRadius: 5,
                      borderWidth: 0.0001,
                      isFilled: true,
                      hint: "Task Content",
                      textInputAction: TextInputAction.newline,
                      borderType: BorderType.outline,
                      keyboardType: TextInputType.multiline,
                      textStyle: const TextStyle(color: Colors.black54, fontSize: 17, fontWeight: FontWeight.w500),
                      maxLines: mediaSize.height ~/ 35,
                    ),
                    const SizedBox(height: 5),
                    if (task != null)
                      Wrap(
                        children: [
                          const Text("Create at: ", style: TextStyle(fontSize: 12)),
                          Text("${task?.createAt}", style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                        ],
                      ),
                    if (task != null)
                      Wrap(
                        children: [
                          const Text("Update at: ", style: TextStyle(fontSize: 12)),
                          Text("${task?.updateAt}", style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                        ],
                      ),
                    const SizedBox(height: 10),
                    model.busy
                        ? const MainProgress()
                        : MainButton(
                            width: double.infinity,
                            radius: 5,
                            title: task == null ? "Add Task" : "Update Task",
                            onPressed: () {
                              task == null ? model.createTask() : model.updateTask(task!.id!);
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
