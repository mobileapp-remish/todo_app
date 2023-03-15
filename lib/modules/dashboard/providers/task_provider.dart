import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_app/modules/add_task/models/task_model.dart';
import 'package:todo_app/utils/helpers/preference_obj.dart';
import 'package:uuid/uuid.dart';

class TaskProvider extends ChangeNotifier {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref(PreferenceObj.getUserId);

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
      return;
    } catch (error) {
      rethrow;
    }
  }
}
