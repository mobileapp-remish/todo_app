import 'package:flutter/material.dart';
import 'package:todo_app/constants/images_path.dart';

class ViewTaskDetailsBottomSheetDialog extends StatelessWidget {
  final String taskTitle;
  final String taskDescription;
  final String taskDate;

  const ViewTaskDetailsBottomSheetDialog({
    required this.taskTitle,
    required this.taskDescription,
    required this.taskDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> taskDateElements = taskDate.split(' ');
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 8,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8)
                ),
                height: 4,
                width: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      radius: 30.0,
                      child: Image.asset(
                        ImagesPath.appLogo,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: Text(
                        taskTitle,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Text(
            taskDescription,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
