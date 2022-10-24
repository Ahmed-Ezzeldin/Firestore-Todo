import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    required this.title,
    required this.content,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String title;
  final String content;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.task_alt),
      title: Text(title),
      subtitle: Text(content, maxLines: 1, overflow: TextOverflow.ellipsis),
      onTap: onTap,
    );
  }
}
