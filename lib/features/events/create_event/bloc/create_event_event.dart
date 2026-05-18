part of 'create_event_bloc.dart';

@immutable
abstract class CreateEventEvent {}

class CategoryChanged extends CreateEventEvent {
  final int index;
  CategoryChanged(this.index);
}

class DateChanged extends CreateEventEvent {
  final DateTime date;
  DateChanged(this.date);
}

class TimeChanged extends CreateEventEvent {
  final TimeOfDay time;
  TimeChanged(this.time);
}

class LocationPicked extends CreateEventEvent {
  final LatLng location;
  LocationPicked(this.location);
}

class SubmitEventRequested extends CreateEventEvent {
  final String title;
  final String description;
  final String categoryId;
  SubmitEventRequested({
    required this.title,
    required this.description,
    required this.categoryId,
  });
}