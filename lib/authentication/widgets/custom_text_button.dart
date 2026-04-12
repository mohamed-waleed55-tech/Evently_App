import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key,required this.title, this.text,required this.onClick});
final String title;
final String? text;
final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text(
          text??"",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        TextButton(
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero
          ),
          onPressed: onClick,
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        )
      ],
    );
  }
}
