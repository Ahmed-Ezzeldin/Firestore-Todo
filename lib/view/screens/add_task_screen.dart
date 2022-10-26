import 'package:firebase_mvvm/model/models/task_model.dart';
import 'package:firebase_mvvm/view/widgets/main_textfield.dart';
import 'package:firebase_mvvm/view/widgets/main_button.dart';
import 'package:firebase_mvvm/view/widgets/main_progress.dart';
import 'package:firebase_mvvm/viewmodel/add_task_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({
    this.task,
    Key? key,
  }) : super(key: key);

  final TaskModel? task;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late AddTaskScreenViewmodel viewModel;
  @override
  void initState() {
    viewModel = Provider.of<AddTaskScreenViewmodel>(context, listen: false);

    viewModel.task = widget.task;
    viewModel.setTaskValues(widget.task);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: viewModel.task == null ? const Text("Add Task Screen") : const Text("Add Task Screen"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Form(
            key: viewModel.formKey,
            autovalidateMode: viewModel.autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainTextField(
                  controller: viewModel.titleController,
                  validator: Validator.required,
                  borderRadius: 5,
                  borderWidth: 0.0001,
                  isFilled: true,
                  hint: "Title",
                  textStyle: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),
                ),
                MainTextField(
                  controller: viewModel.contentController,
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
                if (widget.task != null)
                  Wrap(
                    children: [
                      const Text("Create at: ", style: TextStyle(fontSize: 12)),
                      Text("${widget.task?.createAt}", style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                    ],
                  ),
                if (widget.task != null)
                  Wrap(
                    children: [
                      const Text("Update at: ", style: TextStyle(fontSize: 12)),
                      Text("${widget.task?.updateAt}", style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                    ],
                  ),
                const SizedBox(height: 10),
                viewModel.isBusy
                    ? const MainProgress()
                    : MainButton(
                        width: double.infinity,
                        radius: 5,
                        title: viewModel.task == null ? "Add Task" : "Update Task",
                        onPressed: () {
                          viewModel.task == null
                              ? viewModel.createTask(context)
                              : viewModel.updateTask(context, widget.task!.id!);
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
