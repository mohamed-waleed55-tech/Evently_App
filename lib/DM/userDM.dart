import 'package:cloud_firestore/cloud_firestore.dart';

class UserDM {
  static UserDM? currentUser;
  String id;
  String name;
  String email;
  List<String> favouriteEventsIds;

  UserDM({
    required this.id,
    required this.name,
    required this.email,
    required this.favouriteEventsIds,
  });

  factory UserDM.fromJson(Map<String, dynamic> json) {
    return UserDM(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      favouriteEventsIds:List<String>.from(json["favouriteEventsIds"] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "favouriteEventsIds": favouriteEventsIds,
    };
  }

}
