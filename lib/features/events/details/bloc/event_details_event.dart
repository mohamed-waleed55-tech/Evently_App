part of 'event_details_bloc.dart';
abstract class EventDetailsEvent {}

class DeleteEventRequested extends EventDetailsEvent {
  final String eventId;
  DeleteEventRequested(this.eventId);
}

class ToggleFavoriteEvent extends EventDetailsEvent {
  final String eventId;
  ToggleFavoriteEvent(this.eventId);
}