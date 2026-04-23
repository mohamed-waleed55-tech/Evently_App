import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoadingDialog(BuildContext context, String? loadingMessage) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 16),
              Expanded(child: Text(loadingMessage ?? "Loading...")),
            ],
          ),
        );
      },
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
    BuildContext context, {
    required String message,
    String? title,
    VoidCallback? posAction,
    String? posActionTitle,
    VoidCallback? negAction,
    String? negActionTitle,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        List<Widget> actions = [];
        if(posAction!=null){
          actions.add(
            TextButton(
              onPressed: (){
                Navigator.pop(context);
                posAction();
              },
              child: Text(posActionTitle??""),
            ),
          );
          if(negAction!=null){
            actions.add(
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                  negAction();

                },
                child: Text(negActionTitle??""),
              ),
            );
          }

        }
        return CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions:actions,
        );
      },
    );
  }
}
