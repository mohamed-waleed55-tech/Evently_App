part of 'event_details_bloc.dart';
enum EventDetailsStatus { initial, deleting, success, failure }

class EventDetailsState {
  final EventDetailsStatus status;
  final String? errorMessage;

  EventDetailsState({this.status = EventDetailsStatus.initial, this.errorMessage});

  EventDetailsState copyWith({EventDetailsStatus? status, String? errorMessage}) {
    return EventDetailsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}