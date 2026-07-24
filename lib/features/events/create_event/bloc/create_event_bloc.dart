import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../DM/eventDM.dart';
import '../../../../../DM/userDM.dart';
import '../../../../../core/firebase_service/firestore/firestore_service.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  CreateEventBloc()
      : super(CreateEventState(
          selectedDate: DateTime.now(),
          selectedTime: TimeOfDay.now(),
          status: CreateEventStatus.initial,
        )) {
    on<CategoryChanged>(_onCategoryChanged);
    on<DateChanged>(_onDateChanged);
    on<TimeChanged>(_onTimeChanged);
    on<LocationPicked>(_onLocationPicked);
    on<SubmitEventRequested>(_onSubmitEventRequested);
  }

  void _onCategoryChanged(CategoryChanged event, Emitter<CreateEventState> emit) {
    emit(state.copyWith(selectedIndex: event.index));
  }

  void _onDateChanged(DateChanged event, Emitter<CreateEventState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  void _onTimeChanged(TimeChanged event, Emitter<CreateEventState> emit) {
    emit(state.copyWith(selectedTime: event.time));
  }

  void _onLocationPicked(LocationPicked event, Emitter<CreateEventState> emit) {
    emit(state.copyWith(selectedLocation: event.location));
  }

  Future<void> _onSubmitEventRequested(
    SubmitEventRequested event,
    Emitter<CreateEventState> emit,
  ) async {
    emit(state.copyWith(status: CreateEventStatus.loading));

    try {
      // حماية من Null Reference للـ Current User
      final userId = UserDM.currentUser?.id;
      if (userId == null) {
        emit(state.copyWith(
          status: CreateEventStatus.failure,
          errorMessage: "User not authenticated",
        ));
        return;
      }

      final fullDateTime = state.selectedDate.copyWith(
        hour: state.selectedTime.hour,
        minute: state.selectedTime.minute,
      );

      final newEvent = EventDM(
        title: event.title,
        description: event.description,
        category: event.categoryId,
        imagePath: "",
        dateTime: fullDateTime,
        lat: state.selectedLocation?.latitude,
        lng: state.selectedLocation?.longitude,
        createdById: userId,
      );

      await FirestoreService.addEvent(newEvent);
      emit(state.copyWith(status: CreateEventStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: CreateEventStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}