import 'package:evently/core/resources/icons/icons_manager.dart';
import 'package:evently/core/resources/images/images_manager.dart';
import 'package:flutter/material.dart';

import '../../../DM/CategoryDM.dart';
import '../../../DM/eventDM.dart';

class ConstantManager {
  static List<CategoryDM> categoriesWithAll = [
    CategoryDM(id: "1", name: "All", svgIconPath: IconsManager.all),
    CategoryDM(id: "2", name: "Sport",  svgIconPath: IconsManager.sport),
    CategoryDM(id: "3", name: "BirthDay",  svgIconPath: IconsManager.food),
    CategoryDM(id: "4", name: "Meeting", svgIconPath: IconsManager.book),
    CategoryDM(id: "5", name: "Gamin",  svgIconPath: IconsManager.all),
    CategoryDM(id: "6", name: "Eating",  svgIconPath: IconsManager.all),
    CategoryDM(id: "7", name: "Holiday",  svgIconPath: IconsManager.all),
    CategoryDM(id: "8", name: "Exhibition",  svgIconPath: IconsManager.all),
    CategoryDM(id: "9", name: "WorkShop", svgIconPath: IconsManager.all),
    CategoryDM(id: "9", name: "WorkShop",  svgIconPath: IconsManager.all),
  ];
  static List<CategoryDM> categories = [
    CategoryDM(id: "2", name: "Sport",  svgIconPath: IconsManager.sport),
    CategoryDM(id: "3", name: "BirthDay",  svgIconPath: IconsManager.food),
    CategoryDM(id: "4", name: "Meeting", svgIconPath: IconsManager.book),
    CategoryDM(id: "5", name: "Gamin",  svgIconPath: IconsManager.all),
    CategoryDM(id: "6", name: "Eating",  svgIconPath: IconsManager.all),
    CategoryDM(id: "7", name: "Holiday",  svgIconPath: IconsManager.all),
    CategoryDM(id: "8", name: "Exhibition",  svgIconPath: IconsManager.all),
    CategoryDM(id: "9", name: "WorkShop", svgIconPath: IconsManager.all),
    CategoryDM(id: "9", name: "WorkShop",  svgIconPath: IconsManager.all),
  ];
  static List<EventDM> events = [
    EventDM(
      title: "This is a Birthday Party",
      description: "Celebrate with friends and cake",
      category: "Birthday",
      imagePath: ImagesManager.BookClub,
      dateTime: DateTime(2025, 11, 21),
      time: DateTime(2025, 11, 21, 18, 0),
      lat: 30,
      lng: 31,
    ),
    EventDM(
      title: "Football Match",
      description: "Join us for a fun football game",
      category: "Sport",
      imagePath: ImagesManager.BookClub,
      dateTime: DateTime(2025, 10, 15),
      time: DateTime(2025, 10, 15, 20, 0),
      lat: 30,
      lng: 31,
    ),
    EventDM(
      title: "Team Meeting",
      description: "Discuss project updates",
      category: "Meeting",
      imagePath: ImagesManager.BookClub,
      dateTime: DateTime(2025, 9, 10),
      time: DateTime(2025, 9, 10, 10, 30),
      lat: 30,
      lng: 31,
    ),
    EventDM(
      title: "Gaming Night",
      description: "Play games and have fun",
      category: "Gaming",
      imagePath: ImagesManager.BookClub,
      dateTime: DateTime(2025, 12, 5),
      time: DateTime(2025, 12, 5, 22, 0),
      lat: 30,
      lng: 31,
    ),
    EventDM(
      title: "Food Festival",
      description: "Enjoy delicious food",
      category: "Eating",
      imagePath: ImagesManager.BookClub,
      dateTime: DateTime(2025, 8, 25),
      time: DateTime(2025, 8, 25, 16, 0),
      lat: 30,
      lng: 31,
    ),
  ];
}
