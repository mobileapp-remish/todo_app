import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/add_task/models/task_model.dart';
import 'package:todo_app/modules/dashboard/providers/task_provider.dart';
import 'package:todo_app/modules/dashboard/widgets/view_task_details_bottom_sheet_dialog.dart';
import 'package:todo_app/modules/edit_task/edit_task_screen.dart';
import 'package:todo_app/utils/helpers/helper.dart';
import 'package:todo_app/utils/ui/app_dialogs.dart';

class TaskListItemWidget extends StatelessWidget {
  final TaskModel taskModel;

  const TaskListItemWidget({required this.taskModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final List<String> dateElement = taskModel.date.split(' ');
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (ctx) {
              AppDialogs.showAlertDialog(
                context: context,
                title: 'Are you sure?',
                description: 'Are you sure want to delete this task?',
                firstButtonName: 'No',
                secondButtonName: 'Yes',
                onFirstButtonClicked: () {
                  Navigator.pop(context);
                },
                onSecondButtonClicked: () {
                  Navigator.pop(context);
                  _deleteTask(context: context, taskProvider: taskProvider);
                },
              );
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (ctx) => Navigator.of(context).pushNamed(
              EditTaskScreen.routeName,
              arguments: taskModel,
            ),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      key: ValueKey(taskModel.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              _showTaskDetailsBottomSheet(
                context: context,
                taskModel: taskModel,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        dateElement[0],
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Text(
                          Helper.getShortMonthName(
                              fullMonthName: dateElement[1]),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(
                        height: 1,
                      ),
                      Text(dateElement[2],
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          taskModel.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          taskModel.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  void _deleteTask({
    required BuildContext context,
    required TaskProvider taskProvider,
  }) {
    AppDialogs.showProgressDialog(context: context);
    taskProvider.deleteTask(taskModel: taskModel).then((value) {
      Navigator.pop(context);
    }).catchError((error) {
      Navigator.pop(context);
      AppDialogs.showInformationDialog(
        context: context,
        title: 'Error Occurred!',
        description: error.toString(),
        actionName: 'Ok',
        onActionClick: () {
          Navigator.pop(context);
        },
      );
    });
  }

  Future<void> _showTaskDetailsBottomSheet({
    required BuildContext context,
    required TaskModel taskModel,
  }) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      isDismissible: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return ViewTaskDetailsBottomSheetDialog(
          taskTitle: taskModel.name,
          taskDescription: taskModel.description,
          taskDate: taskModel.date,
        );
      },
    );
  }
}
