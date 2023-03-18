import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/modules/add_task/models/task_model.dart';
import 'package:todo_app/utils/helpers/preference_obj.dart';
import 'package:uuid/uuid.dart';

class TaskProvider extends ChangeNotifier {
  late DatabaseReference? _databaseReference;
  final List<TaskModel> taskList = [];
  late List<TaskModel> tempTaskList = [];
  late String searchString = "";
  late bool isLoading = true;
  late bool hasError = false;
  late String errorString = '';

  void initData() {
    _databaseReference = FirebaseDatabase.instance.ref(PreferenceObj.getUserId);
  }

  void clearData() {
    _databaseReference = null;
    taskList.clear();
    tempTaskList.clear();
    searchString = '';
    isLoading = true;
    hasError = false;
    errorString = '';
    notifyListeners();
  }

  void onClear() {
    tempTaskList = taskList;
    notifyListeners();
  }

  void onTextSearching(String query) {
    searchString = query;
    if (query.isNotEmpty) {
      tempTaskList = taskList
          .where((element) => (element.name + element.date)
              .trim()
              .toLowerCase()
              .contains(query.trim().toLowerCase()))
          .toList();
    } else if (query.isEmpty) {
      tempTaskList = taskList;
    }
    notifyListeners();
  }

  Future<void> getAllTask() async {
    try {
      isLoading = true;
      hasError = false;
      errorString = '';
      taskList.clear();
      tempTaskList.clear();
      DataSnapshot dataSnapshot = await _databaseReference!.get();
      for (var element in dataSnapshot.children) {
        taskList.insert(
          0,
          TaskModel.fromJson(
            json.decode(
              jsonEncode(
                element.value,
              ),
            ),
          ),
        );
      }
      tempTaskList = taskList;
      isLoading = false;
      hasError = false;
      errorString = '';
      notifyListeners();
    } on PlatformException catch (e) {
      errorString = e.code;
      if (e.code == 'network_error') {
        errorString = 'Please check your internet connection!';
      }
      isLoading = false;
      hasError = true;
      notifyListeners();
    } catch (error) {
      errorString = error.toString();
      isLoading = false;
      hasError = true;
      notifyListeners();
    }
  }

  Future<void> refreshTask() async {
    try {
      DataSnapshot dataSnapshot = await _databaseReference!.get();
      taskList.clear();
      for (var element in dataSnapshot.children) {
        taskList.insert(
          0,
          TaskModel.fromJson(
            json.decode(
              jsonEncode(
                element.value,
              ),
            ),
          ),
        );
      }
      tempTaskList = taskList;
      if (searchString.isNotEmpty) {
        tempTaskList = taskList.reversed
            .toList()
            .where((element) =>
                (element.name + element.date).toLowerCase() ==
                searchString.toLowerCase())
            .toList();
      }
      notifyListeners();
    } catch (error) {
      return;
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
      await _databaseReference!.child(taskModel.id).set(taskModel.toJson());
      taskList.insert(0, taskModel);
      tempTaskList = taskList;
      notifyListeners();
      return;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> editTask({required TaskModel taskModel}) async {
    try {
      await _databaseReference!.child(taskModel.id).set(taskModel.toJson());
      final int taskIndex = taskList.indexWhere((element) =>
          element.id.toLowerCase().trim() == taskModel.id.toLowerCase().trim());
      taskList[taskIndex] = taskModel;
      tempTaskList = taskList;
      notifyListeners();
      return;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteTask({required TaskModel taskModel}) async {
    try {
      await _databaseReference!.child(taskModel.id).remove();
      taskList.removeWhere((element) =>
          element.id.toLowerCase().trim() == taskModel.id.toLowerCase().trim());
      tempTaskList = taskList;
      notifyListeners();
      return;
    } catch (error) {
      rethrow;
    }
  }
}
