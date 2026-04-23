import 'package:flutter/material.dart';

class CategoryDM {
  final String id;
  final String name;
  final IconData icon;
  final String darkImgPath;
  final String lightImgPath;

  CategoryDM({
    required this.id,
    required this.name,
    required this.icon,
    required this.darkImgPath,
    required this.lightImgPath,
  });
}