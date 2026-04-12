import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    this.lines=1,
     this.label,
     this.prefixIcon,
    this.suffixIcon,
    this.isSecure = false,
    this.onClick,
  this.hint
  });

  final String? label;
  final IconData? prefixIcon;
  final String? hint;
  final int lines;
  IconData? suffixIcon;
  bool isSecure;
  VoidCallback? onClick;


  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyLarge,
      obscureText: widget.isSecure,
      maxLines: widget.lines,
      decoration: InputDecoration(

        hintText: widget.hint,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        labelText: widget.label,
        prefixIcon: widget.prefixIcon!=null? Icon(widget.prefixIcon):null,
        suffixIcon: IconButton(onPressed: widget.onClick, icon: Icon(widget.suffixIcon))
      ),
    );
  }
}
