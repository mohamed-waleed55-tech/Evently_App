part of 'create_event_bloc.dart';

enum CreateEventStatus { initial, loading, success, failure }

class CreateEventState {
  final int selectedIndex;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final LatLng? selectedLocation;
  final CreateEventStatus status;
  final String? errorMessage;

  CreateEventState({
    this.selectedIndex = 0,
    required this.selectedDate,
    required this.selectedTime,
    this.selectedLocation,
    this.status = CreateEventStatus.initial,
    this.errorMessage,
  });

  factory CreateEventState.initial() {
    return CreateEventState(
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.now(),
      status: CreateEventStatus.initial,
    );
  }

  CreateEventState copyWith({
    int? selectedIndex,
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    LatLng? selectedLocation,
    CreateEventStatus? status,
    String? errorMessage,
  }) {
    return CreateEventState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
