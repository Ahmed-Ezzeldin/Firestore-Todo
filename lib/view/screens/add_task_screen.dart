// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/model/services/base/base_model.dart';
import 'package:firebase_mvvm/model/services/base/base_widget.dart';
import 'package:firebase_mvvm/model/services/provider_setup.dart';
import 'package:firebase_mvvm/view/widgets/components/main_button.dart';
import 'package:firebase_mvvm/view/widgets/components/main_progress.dart';
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
              child: Form(
                key: model.formKey,
                autovalidateMode: model.autovalidateMode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MainTextField(
                      controller: model.titleController,
                      validator: Validator.required,
                      borderRadius: 5,
                      hint: "Title",
                      isFilled: true,
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    MainTextField(
                      controller: model.contentController,
                      validator: Validator.required,
                      borderRadius: 5,
                      hint: "Task Content",
                      isFilled: true,
                      keyboardType: TextInputType.multiline,
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      maxLines: mediaSize.height ~/ 35,
                    ),
                    const SizedBox(height: 20),
                    model.busy
                        ? const MainProgress()
                        : MainButton(
                            width: double.infinity,
                            radius: 5,
                            title: "Add Task",
                            onPressed: model.createTask,
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

class AddTaskScreenModel extends BaseModel {
  final BuildContext context;
  AddTaskScreenModel({required this.context});

  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createTask() async {
    if (formKey.currentState!.validate()) {
      setBusy();
      AppHelper.unfocusFun(context);
      String id = DateTime.now().toString();
      try {
        setBusy();
        await firestore.collection(auth.user?.uid ?? "Not_User").doc(id).set({
          "id": id,
          "title": titleController.text,
          "content": contentController.text,
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
}
