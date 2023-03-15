import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/modules/add_task/models/task_model.dart';
import 'package:todo_app/modules/add_task/screens/add_task_screen.dart';
import 'package:todo_app/modules/dashboard/widgets/app_drawer.dart';
import 'package:todo_app/utils/helpers/preference_obj.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = '/Dashboard-Screen';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dashboard'),
      ),
      body: Container(),
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
