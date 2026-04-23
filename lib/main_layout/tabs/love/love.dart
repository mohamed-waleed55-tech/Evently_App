import 'package:flutter/material.dart';

import '../../../DM/eventDM.dart';
import '../../../DM/userDM.dart';
import '../../../firebase_service/firestore/firestore_service.dart';
import '../home/widgets/evenItem.dart';

class Love extends StatelessWidget {
  const Love({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Events"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<EventDM>>(
        stream: FirestoreService.getFavEventsStream(
          UserDM.currentUser!.id,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final events = snapshot.data ?? [];

          if (events.isEmpty) {
            return Center(
              child: Text("No favourite events",style: Theme.of(context).textTheme.labelMedium,),
            );
          }

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: EventCard(event: event),
              );
            },
          );
        },
      ),
    );
  }
}