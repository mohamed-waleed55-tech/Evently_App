import 'package:cloud_firestore/cloud_firestore.dart';

class EventDM {
  String id;
  final String title;
  final String description;
  final String category;
  final String imagePath;
  final DateTime dateTime;
  final double? lat;
  final double? lng;
  final String createdById;

  EventDM({
    required this.title,
    required this.description,
    required this.category,
    required this.imagePath,
    required this.dateTime,
    this.lat,
    this.lng,
    this.id = "",
    this.createdById = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "category": category,
      "imagePath": imagePath,
      "dateTime": Timestamp.fromDate(dateTime),
      "lat": lat,
      "lng": lng,
      "createdById": createdById,
    };
  }

  factory EventDM.fromJson(Map<String, dynamic> json) {
    return EventDM(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      category: json["category"],
      imagePath: json["imagePath"],
      dateTime: (json["dateTime"] as Timestamp).toDate(),
      lat: json["lat"],
      lng: json["lng"],
      createdById: json["createdById"],
    );
  }
}
