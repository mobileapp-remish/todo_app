import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/add_task/models/task_model.dart';
import 'package:todo_app/modules/dashboard/providers/task_provider.dart';
import 'package:todo_app/modules/dashboard/screens/dashboard_screen.dart';
import 'package:todo_app/utils/helpers/helper.dart';
import 'package:todo_app/utils/ui/app_dialogs.dart';
import 'package:todo_app/utils/ui/common_style.dart';

class EditTaskScreen extends StatelessWidget {
  static const String routeName = '/Edit-Task-Screen';

  EditTaskScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _taskTitle = TextEditingController();
  final TextEditingController _taskDescription = TextEditingController();
  final TextEditingController _taskDate = TextEditingController();
  late TaskModel _taskModel;

  void _initData({required BuildContext context}) {
    _taskModel = ModalRoute.of(context)!.settings.arguments as TaskModel;
    _taskTitle.text = _taskModel.name;
    _taskDescription.text = _taskModel.description;
    _taskDate.text = _taskModel.date;
  }

  @override
  Widget build(BuildContext context) {
    _initData(context: context);
    final TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Update Task'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _globalKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  primary: false,
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      controller: _taskTitle,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      maxLength: 600,
                      maxLines: 1,
                      decoration: CommonStyle
                          .getTextFormFiledDecorationForCreateNewTask(
                        label: 'Title',
                        hintText: 'Enter your task title',
                        prefixIcon: Icons.title,
                      ),
                      validator: (enteredTaskName) {
                        if (enteredTaskName == null ||
                            enteredTaskName.trim().isEmpty) {
                          return '⚠️ Please enter task title!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _taskDescription,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      maxLength: 2000,
                      maxLines: 8,
                      minLines: 4,
                      decoration: CommonStyle
                          .getTextFormFiledDecorationForCreateNewTask(
                        label: 'Description',
                        hintText: 'Enter Task Description',
                        prefixIcon: Icons.task,
                      ),
                      validator: (enteredTaskDescription) {
                        if (enteredTaskDescription == null ||
                            enteredTaskDescription.trim().isEmpty) {
                          return '⚠️ Please enter task description!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _taskDate,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.datetime,
                      maxLines: 1,
                      readOnly: true,
                      onTap: () => _selectDate(context: context),
                      decoration: CommonStyle
                          .getTextFormFiledDecorationForCreateNewTask(
                        label: 'Date',
                        hintText: 'Select your task date',
                        prefixIcon: Icons.date_range,
                      ),
                      validator: (enteredTaskDate) {
                        if (enteredTaskDate == null ||
                            enteredTaskDate.trim().isEmpty) {
                          return '⚠️ Please select task date!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_globalKey.currentState!.validate()) {
                    _globalKey.currentState!.save();
                    AppDialogs.showProgressDialog(context: context);
                    _taskModel.setName = _taskTitle.text.trim();
                    _taskModel.setDescription = _taskDescription.text.trim();
                    _taskModel.setDate = _taskDate.text.trim();
                    taskProvider.editTask(taskModel: _taskModel).then((value) {
                      Navigator.pop(context);
                      AppDialogs.showInformationDialog(
                        context: context,
                        title: 'Task Updated!',
                        description: 'Task Details has been updated!',
                        actionName: 'Ok',
                        onActionClick: () {
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName(DashboardScreen.routeName),
                          );
                        },
                      );
                    }).catchError((error) {
                      Navigator.pop(context);
                      AppDialogs.showAlertDialog(
                        context: context,
                        title: 'Error Occurred!',
                        description: error.toString(),
                        firstButtonName: 'Try Again',
                        secondButtonName: 'Go To Home',
                        onFirstButtonClicked: () {
                          Navigator.pop(context);
                        },
                        onSecondButtonClicked: () {
                          Navigator.popUntil(
                            context,
                            ModalRoute.withName(DashboardScreen.routeName),
                          );
                        },
                      );
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Update TASK'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _selectDate({required BuildContext context}) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    ).then(
      (selectedDate) {
        _taskDate.text = Helper.formatDate(date: selectedDate!);
      },
    );
  }
}
