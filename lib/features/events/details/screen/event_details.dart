import 'package:evently/DM/eventDM.dart';
import 'package:evently/DM/userDM.dart';
import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/core/utils/dialog.dart';
import 'package:evently/features/tabs/map/provider/location_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../bloc/event_details_bloc.dart';
import '../widgets/event_details_body.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key, required this.event});
  final EventDM event;

  @override
  Widget build(BuildContext context) {
    final bool isOwner = UserDM.currentUser?.id == event.createdById;

    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => EventDetailsBloc()),
        ChangeNotifierProvider(create: (_) => LocationMapProvider()),
      ],
      child: BlocListener<EventDetailsBloc, EventDetailsState>(
        listener: _handleBlocState,
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          body: CustomScrollView(
            slivers: [
              // Custom Sliver App Bar for Modern UI Experience
              SliverAppBar(
                expandedHeight: 220.0,
                pinned: true,
                backgroundColor: ColorsManager.blue,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withValues(alpha: .9),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                actions: isOwner ? [_buildOwnerActions(context)] : null,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                  title: Text(
                    event.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 3.0,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Event Cover Image with Fallback
                      event.imagePath.isNotEmpty
                          ? Image.network(
                              event.imagePath,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: ColorsManager.blue,
                              child: const Icon(
                                Icons.event,
                                size: 80,
                                color: Colors.white54,
                              ),
                            ),
                      // Gradient overlay for better text readability
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: .3),
                              Colors.transparent,
                              Colors.black.withValues(alpha: .7),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Main Body Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                  child: EventDetailsBody(event: event),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOwnerActions(BuildContext context) {
    return Builder(
      builder: (blocContext) {
        return Row(
          children: [
            // Edit Button
            CircleAvatar(
              backgroundColor: Colors.white.withValues(alpha: .9),
              child: IconButton(
                icon: const Icon(Icons.edit_outlined, color: ColorsManager.blue),
                onPressed: () => Navigator.pushNamed(
                  context,
                  RoutesManager.updateEvent,
                  arguments: event,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Delete Button
            CircleAvatar(
              backgroundColor: Colors.white.withValues(alpha: .9),
              child: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                onPressed: () => _showDeleteConfirm(blocContext),
              ),
            ),
            const SizedBox(width: 12),
          ],
        );
      },
    );
  }

  /// Handle States from BLoC Listener
  void _handleBlocState(BuildContext context, EventDetailsState state) {
    if (state.status == EventDetailsStatus.deleting) {
      DialogUtils.showLoadingDialog(context, "Deleting Event...");
    } else if (state.status == EventDetailsStatus.success) {
      Navigator.pop(context); // Close loading dialog
      Navigator.pop(context); // Return to previous screen
    } else if (state.status == EventDetailsStatus.failure) {
      Navigator.pop(context); // Close loading dialog
      DialogUtils.showMessage(
        context,
        message: state.errorMessage ?? "An error occurred while deleting.",
      );
    }
  }

  void _showDeleteConfirm(BuildContext context) {
    DialogUtils.showMessage(
      context,
      message: "Are you sure you want to delete this event? This action cannot be undone.",
      title: "Delete Event",
      posActionTitle: "Delete",
      posAction: () {
        context.read<EventDetailsBloc>().add(DeleteEventRequested(event.id));
      },
      negActionTitle: "Cancel",
    );
  }
}