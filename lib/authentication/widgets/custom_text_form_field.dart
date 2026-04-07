import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.label,
    required this.prefixIcon,
    this.suffixIcon,
    this.isSecure = false,
    this.onClick
  });

  final String label;
  final IconData prefixIcon;
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
      obscureText: widget.isSecure,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(onPressed: widget.onClick, icon: Icon(widget.suffixIcon))
      ),
    );
  }
}
