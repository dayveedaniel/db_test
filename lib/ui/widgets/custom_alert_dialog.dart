import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertUtils {
  static Future<bool> deleteTweetDialog(BuildContext context) async =>
      await showDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
                title: const Text('Delete this tweet'),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text('Cancel'),
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text('Delete'),
                  )
                ],
              ));
}
