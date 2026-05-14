import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/DM/eventDM.dart';
import 'package:evently/DM/userDM.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
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
    await FirebaseFirestore.instance.collection("users").doc(user.id).set({
      "id": user.id,
      "name": user.name ?? "",
      "email": user.email ?? "",
      "favouriteEventsIds": [],
    });
  }

  static Future<bool> isUserExistInFirestore(String userId) async {
    var user = await getUserCollection().doc(userId).get();
    return user.exists;
  }

  static Future<UserDM?> getUserFromFirestore(String userId) async {
    var doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get();

    if (!doc.exists) {
      await createUserInFirestore(userId);

      doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();
    }

    if (doc.exists) {
      return UserDM.fromJson(doc.data()!);
    }

    return null;
  }

  // if (!doc.exists) {
  //   await Future.delayed(const Duration(milliseconds: 300));
  //   return getUserFromFirestore(userId);
  // }

  static Future<void> createUserInFirestore(String userId) async {
    final user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance.collection("users").doc(userId).set({
        "id": userId,
        "name": user?.displayName ?? "",
        "email": user?.email ?? "",
        "favouriteEventsIds": [],
      });
    } catch (e) {
      print("Error creating user in Firestore: $e");
    }
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
  static Future<void> updateEvent(EventDM event) async {
    try {
      final eventsCollection = getEventsCollection();
      await eventsCollection.doc(event.id).update(event.toJson());
    } catch (e) {
      print("Error updating event: $e");
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
  static Future<void> deleteEvent(String eventId) async {
    try {
      final eventsCollection = getEventsCollection();
      await eventsCollection.doc(eventId).delete();
    } catch (e) {
      print("Error deleting event: $e");
    }
  }
}
