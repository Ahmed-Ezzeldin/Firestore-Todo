import 'package:firebase_mvvm/model/services/base/base_model.dart';
import 'package:firebase_mvvm/model/services/base/base_widget.dart';
import 'package:firebase_mvvm/view/widgets/task_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeScreenModel>(
      model: HomeScreenModel(context: context),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Tasks List")),
          body: ListView.builder(
            itemCount: 12,
            itemBuilder: (context, index) {
              return const TaskItem(
                title: "Title Title",
                subtitle: "Subitle subtitle subtitle subtitle subtitle",
              );
            },
          ),
        );
      },
    );
  }
}

class HomeScreenModel extends BaseModel {
  final BuildContext context;

  HomeScreenModel({required this.context});
}
