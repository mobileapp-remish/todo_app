import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/add_task/models/task_model.dart';
import 'package:todo_app/modules/add_task/screens/add_task_screen.dart';
import 'package:todo_app/modules/dashboard/providers/task_provider.dart';
import 'package:todo_app/modules/dashboard/widgets/app_drawer.dart';
import 'package:todo_app/modules/dashboard/widgets/task_list_item_widget.dart';
import 'package:todo_app/utils/helpers/preference_obj.dart';
import 'package:todo_app/widgets/loading_widget.dart';
import 'package:todo_app/widgets/something_went_wrong_widget.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/Dashboard-Screen';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false)..getAllTask();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Dashboard'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        child: Consumer<TaskProvider>(
          builder: (ctx, _, child) => taskProvider.isLoading
              ? const LoadingWidget()
              : taskProvider.hasError
                  ? SomethingWentWrong(
                      errorString: taskProvider.errorString,
                      onTryAgainClick: () => taskProvider.getAllTask(),
                    )
                  : ListView.builder(
                      itemCount: taskProvider.taskList.length,
                      itemBuilder: (ctx, index) => TaskListItemWidget(
                        taskModel: taskProvider.taskList[index],
                      ),
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.of(context).pushNamed(AddTaskScreen.routeName),
        icon: const Icon(Icons.add),
        label: const Text(
          'Create New Task',
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
