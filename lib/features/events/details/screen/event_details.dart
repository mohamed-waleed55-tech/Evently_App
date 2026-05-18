import 'package:evently/DM/eventDM.dart';
import 'package:evently/DM/userDM.dart';
import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:evently/core/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../../core/resources/routes/routes_manager.dart';
import '../bloc/event_details_bloc.dart';
import '../widgets/event_details_body.dart';
class EventDetails extends StatelessWidget {
  const EventDetails({super.key, required this.event});
  final EventDM event;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventDetailsBloc(),
      child: BlocListener<EventDetailsBloc, EventDetailsState>(
        listener: (context, state) {
          if (state.status == EventDetailsStatus.deleting) {
            DialogUtils.showLoadingDialog(context, "Deleting...");
          } else if (state.status == EventDetailsStatus.success) {
            Navigator.pop(context);
            Navigator.pop(context);
          } else if (state.status == EventDetailsStatus.failure) {
            Navigator.pop(context);
            DialogUtils.showMessage(context, message: state.errorMessage ?? "Error");
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Event Details"),
            actions: UserDM.currentUser!.id == event.createdById
                ? [
              IconButton(
                onPressed: () => Navigator.pushNamed(context, RoutesManager.updateEvent, arguments: event),
                icon: const Icon(Icons.edit_note_outlined, color: ColorsManager.blue),
              ),
              Builder(builder: (blocContext) {
                return IconButton(
                  onPressed: () => _showDeleteConfirm(blocContext),
                  icon: const Icon(Icons.delete_outline_outlined, color: ColorsManager.blue),
                );
              }),
            ]
                : [],
          ),
          body: EventDetailsBody(event: event),
        ),
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context) {
    DialogUtils.showMessage(
      context,
      message: "Are you sure you want to delete this event?",
      title: "Delete Event",
      posActionTitle: "Delete",
      posAction: () {
        context.read<EventDetailsBloc>().add(DeleteEventRequested(event.id));
      },
      negActionTitle: "Cancel",
    );
  }
}