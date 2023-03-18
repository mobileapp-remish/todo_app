import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  final String errorString;
  final Function onTryAgainClick;

  const SomethingWentWrong({
    required this.errorString,
    required this.onTryAgainClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(errorString),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton.icon(
            onPressed: () => onTryAgainClick(),
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            label: const Text(
              'Try Again!',
            ),
          )
        ],
      ),
    );
  }
}
