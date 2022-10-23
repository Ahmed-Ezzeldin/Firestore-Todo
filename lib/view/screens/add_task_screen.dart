import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/model/services/base/base_model.dart';
import 'package:firebase_mvvm/model/services/base/base_widget.dart';
import 'package:firebase_mvvm/view/widgets/components/main_button.dart';
import 'package:firebase_mvvm/view/widgets/components/main_textfield.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       final Size mediaSize = MediaQuery.of(context).size;
    return BaseWidget<AddTaskScreenModel>(
      model: AddTaskScreenModel(context: context),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Add Task Screen")),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MainTextField(
                    controller: model.titleController,
                    hint: "Title",
                    isFilled: true,
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  MainTextField(
                    controller: model.contentController,
                    hint: "Task Content",
                    isFilled: true,
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    maxLines: mediaSize.height ~/ 30,
                  ),
                  const SizedBox(height: 20),
                  MainButton(
                    width: double.infinity,
                    radius: 5,
                    title: "Add Task",
                    onPressed: () {
                      AppHelper.unfocusFun(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AddTaskScreenModel extends BaseModel {
  final BuildContext context;
  AddTaskScreenModel({required this.context});
  final titleController = TextEditingController();
  final contentController = TextEditingController();
}
