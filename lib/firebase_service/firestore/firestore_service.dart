import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/DM/eventDM.dart';
import 'package:evently/DM/userDM.dart';

class FirestoreService {
  static CollectionReference<EventDM> getEventsCollection() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<EventDM> eventsCollection = db
        .collection("events")
        .withConverter(
      fromFirestore: (snapshot, options) =>
          EventDM.fromJson(snapshot.data()!),
      toFirestore: (event, options) => event.toJson(),
    );
    return eventsCollection;
  }

  static Future<void> addEvent(EventDM event) async {
    CollectionReference<EventDM> eventsCollection = getEventsCollection();
    DocumentReference<EventDM> doc = eventsCollection.doc();
    event.id = doc.id;
    await doc.set(event);
  }


  static Stream<List<EventDM>> getEventsStream(String categoryId) {
    final query = getEventsCollection();

    final filtered = (categoryId == "0")
        ? query
        : query.where("category", isEqualTo: categoryId);

    return filtered
        .orderBy("dateTime", descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }



  static CollectionReference<UserDM> getUserCollection() {
    return FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserDM>(
      fromFirestore: (snap, _) => UserDM.fromJson(snap.data()!),
      toFirestore: (user, _) => user.toJson(),
    );
  }
  static Future<void> addUserToFirestore(UserDM user) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.id)
        .set({
      "id": user.id,
      "name": user.name ?? "",
      "email": user.email ?? "",
      "favouriteEventsIds": [],
    });
  }
  static Future<UserDM?> getUserFromFirestore(String userId) async {
    final usersCollection = getUserCollection();

    final snapshot = await usersCollection.doc(userId).get();
    print("USER ID: $userId");
    print("EXISTS: ${snapshot.exists}");
    print("DATA: ${snapshot.data()}");
    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }
    print("USER ID: $userId");
    print("EXISTS: ${snapshot.exists}");
    print("DATA: ${snapshot.data()}");

    return snapshot.data();
  }

  static Future<void> addEventsToFav(String eventId) async {
    try {
      final user = UserDM.currentUser!;
      if (eventId.trim().isEmpty) return;
      print("////////////////////////////////////////////////////////////////");
      print(eventId);

      final usersCollection = await getUserCollection();
      print("/////////////////${user.id.toString()}");
      print("/////////////////${eventId.toString()}");


      await usersCollection.doc(user.id).update({
        "favouriteEventsIds": FieldValue.arrayUnion([eventId]),
      });

      user.favouriteEventsIds.add(eventId);

    } catch (e) {
      print("Error adding event to favourites: $e");

    }
  }
  static Future<void> removeEventFromFav(String eventId) async {
    try {
      final user = UserDM.currentUser!;



      final usersCollection = await getUserCollection();

      await usersCollection.doc(user.id).update({
        "favouriteEventsIds": FieldValue.arrayRemove([eventId]),
      });

      user.favouriteEventsIds.remove(eventId);

    } catch (e) {
      print("Error removing event from favourites: $e");
    }
  }
  static Future<void> toggleFavorite(String eventId) async {
    final user = UserDM.currentUser!;

    if (user.favouriteEventsIds.contains(eventId)) {
       await removeEventFromFav(eventId);
    } else {
       await addEventsToFav(eventId);
    }
  }
  static Stream<List<String>> getFavStreamIds(String userId) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .snapshots()
        .map((doc) {
      final data = doc.data();
      if (data == null) return [];
      return List<String>.from(data["favouriteEventsIds"] ?? []);
    });
  }

  static Stream<List<EventDM>> getFavEventsStream(String userId) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .snapshots()
        .asyncMap((doc) async {
      final data = doc.data();
      final ids = List<String>.from(data?["favouriteEventsIds"] ?? []);

      final events = await Future.wait(
        ids.map((id) async {
          final eventDoc = await FirebaseFirestore.instance
              .collection("events")
              .doc(id)
              .get();

          return EventDM.fromJson(eventDoc.data()!);
        }),
      );

      return events;
    });
  }

}
