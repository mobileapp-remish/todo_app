import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/add_task/models/task_model.dart';
import 'package:todo_app/modules/add_task/screens/add_task_screen.dart';
import 'package:todo_app/modules/dashboard/providers/task_provider.dart';
import 'package:todo_app/modules/dashboard/widgets/app_drawer.dart';
import 'package:todo_app/modules/dashboard/widgets/task_list_item_widget.dart';
import 'package:todo_app/shapes/arc.dart';
import 'package:todo_app/shapes/shape_of_view_null_safe.dart';
import 'package:todo_app/utils/helpers/preference_obj.dart';
import 'package:todo_app/widgets/loading_widget.dart';
import 'package:todo_app/widgets/no_data_found_widget.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text('Dashboard'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ShapeOfView(
                shape: ArcShape(height: 30),
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Text(
                          PreferenceObj.getName!.substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        PreferenceObj.getName!,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
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
                          : taskProvider.taskList.isEmpty
                              ? const NoDataFoundWidget()
                              : ListView.builder(
                                  itemCount: taskProvider.taskList.length,
                                  itemBuilder: (ctx, index) =>
                                      TaskListItemWidget(
                                    taskModel: taskProvider.taskList[index],
                                  ),
                                ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(AddTaskScreen.routeName),
          child: const Icon(Icons.add),
          // label: const Text(
          //   'Create New Task',
          // ),
        ),
        drawer: const AppDrawer(),
      ),
    );
  }
}
