import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/add_task/screens/add_task_screen.dart';
import 'package:todo_app/modules/dashboard/providers/task_provider.dart';
import 'package:todo_app/modules/dashboard/widgets/app_drawer.dart';
import 'package:todo_app/modules/dashboard/widgets/dashboard_appbar_widget.dart';
import 'package:todo_app/modules/dashboard/widgets/task_list_item_widget.dart';
import 'package:todo_app/widgets/loading_widget.dart';
import 'package:todo_app/widgets/no_data_found_widget.dart';
import 'package:todo_app/widgets/something_went_wrong_widget.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/Dashboard-Screen';

  DashboardScreen({Key? key}) : super(key: key);

  late TaskProvider _taskProvider;

  @override
  Widget build(BuildContext context) {
    _taskProvider = Provider.of<TaskProvider>(context, listen: false)
      ..getAllTask();
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: DashboardAppbar(
              onClear: _taskProvider.onClear,
              onTextSearching: _taskProvider.onTextSearching,
              labelName: 'Search tasks...',
            ),
          ),
          body: Consumer<TaskProvider>(
            builder: (ctx, _, child) => _taskProvider.isLoading
                ? const LoadingWidget()
                : _taskProvider.hasError
                    ? SomethingWentWrong(
                        errorString: _taskProvider.errorString,
                        onTryAgainClick: () => _taskProvider.getAllTask(),
                      )
                    : _taskProvider.tempTaskList.isEmpty
                        ? _taskProvider.searchString.isNotEmpty
                            ? Center(
                                child: Text(
                                  'No Result found for "${_taskProvider.searchString}"',
                                ),
                              )
                            : const NoDataFoundWidget()
                        : RefreshIndicator(
                            onRefresh: () => _taskProvider.refreshTask(),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: _taskProvider.tempTaskList.length,
                              itemBuilder: (ctx, index) => TaskListItemWidget(
                                taskModel: _taskProvider.tempTaskList[index],
                              ),
                            ),
                          ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddTaskScreen.routeName),
            child: const Icon(Icons.add),
          ),
          drawer: const AppDrawer(),
        ),
    );
  }
}
