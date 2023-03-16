import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_app/modules/add_task/models/task_model.dart';
import 'package:todo_app/utils/helpers/preference_obj.dart';
import 'package:uuid/uuid.dart';

class TaskProvider extends ChangeNotifier {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref(PreferenceObj.getUserId);
  final List<TaskModel> taskList = [];
  late bool isLoading = true;
  late bool hasError = false;
  late String errorString = '';

  Future<void> getAllTask() async {
    try {
      isLoading = true;
      hasError = false;
      errorString = '';
      taskList.clear();
      DataSnapshot dataSnapshot = await _databaseReference.get();
      for (var element in dataSnapshot.children) {
        taskList.add(
          TaskModel.fromJson(
            json.decode(
              jsonEncode(
                element.value,
              ),
            ),
          ),
        );
      }
      isLoading = false;
      hasError = false;
      errorString = '';
      notifyListeners();
    } catch (error) {
      isLoading = false;
      hasError = true;
      errorString = error.toString();
      notifyListeners();
    }
  }

  Future<void> createNewTask({
    required String name,
    required String description,
    required String date,
  }) async {
    try {
      TaskModel taskModel = TaskModel.fromJson({
        'id': const Uuid().v1(),
        'name': name,
        'description': description,
        'date': date,
      });
      await _databaseReference.child(taskModel.id).set(taskModel.toJson());
      taskList.insert(0, taskModel);
      notifyListeners();
      return;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> editTask({required TaskModel taskModel}) async {
    try {
      await _databaseReference.child(taskModel.id).set({
        'name': taskModel.name,
        'description': taskModel.description,
        'date': taskModel.date,
      });
      final int taskIndex = taskList.indexWhere((element) =>
          element.id.toLowerCase().trim() == taskModel.id.toLowerCase().trim());
      taskList[taskIndex] = taskModel;
      notifyListeners();
      return;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteTask({required TaskModel taskModel}) async {
    try {
      await _databaseReference.child(taskModel.id).remove();
      taskList.removeWhere((element) =>
          element.id.toLowerCase().trim() == taskModel.id.toLowerCase().trim());
      notifyListeners();
      return;
    } catch (error) {
      rethrow;
    }
  }
}
