import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../DM/eventDM.dart';
import '../../../DM/userDM.dart';
import '../../../firebase_service/firestore/firestore_service.dart';
import '../home/widgets/evenItem.dart';

class Love extends StatefulWidget {
  const Love({super.key});

  @override
  State<Love> createState() => _LoveState();
}

class _LoveState extends State<Love> {
  List<EventDM> events = [];
  List<EventDM> filteredEvents = [];
  String searchQuery = "";


  @override
  Widget build(BuildContext context) {
    if (UserDM.currentUser == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,


      appBar: AppBar(
        title: const Text("Favourite Events"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding:  REdgeInsets.only(top: 16.0,left: 16,right: 16),
            child: CustomTextFormField(
              prefixIcon: Icons.search,
              label: "Search",
              onChange: (query){
                searchEvent(query);
              },
            ),
          ),
          SizedBox(height: 16.h),

          Expanded(
            child: StreamBuilder<List<EventDM>>(
              stream: FirestoreService.getFavEventsStream(
                UserDM.currentUser!.id,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                events = snapshot.data ?? [];

                filteredEvents = searchQuery.isEmpty
                    ? List.from(events)
                    : events
                    .where((e) =>
                    e.title.toLowerCase().contains(searchQuery))
                    .toList();

                if (filteredEvents.isEmpty) {
                  return Center(
                    child: Text(
                      "No favourite events",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredEvents.length,
                  itemBuilder: (context, index) {
                    print(filteredEvents.length);
                    final event = filteredEvents[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: EventCard(event: event),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void searchEvent(String query) {
    setState(() {
      searchQuery = query;
    });
    setState(() {
      filteredEvents = events.where((event) {
        return event.title
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    });
  }
}