import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    required this.title,
    required this.subtitle,
    Key? key,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.task_alt),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
