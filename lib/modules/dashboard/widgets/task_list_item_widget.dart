import 'package:flutter/material.dart';
import 'package:todo_app/modules/add_task/models/task_model.dart';

class TaskListItemWidget extends StatelessWidget {
  final TaskModel taskModel;

  const TaskListItemWidget({required this.taskModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(taskModel.name),
      subtitle: Text(taskModel.description),
      trailing: Text(taskModel.date),
    );
  }
}
