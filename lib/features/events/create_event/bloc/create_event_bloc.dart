import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../../../DM/eventDM.dart';
import '../../../../../DM/userDM.dart';
import '../../../../../core/firebase_service/firestore/firestore_service.dart';



part 'create_event_event.dart';
part 'create_event_state.dart';
class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  CreateEventBloc() : super(CreateEventState(
    selectedDate: DateTime.now(),
    selectedTime: TimeOfDay.now(),
  )) {
    on<CategoryChanged>((event, emit) => emit(state.copyWith(selectedIndex: event.index)));
    on<DateChanged>((event, emit) => emit(state.copyWith(selectedDate: event.date)));
    on<TimeChanged>((event, emit) => emit(state.copyWith(selectedTime: event.time)));
    on<LocationPicked>((event, emit) => emit(state.copyWith(selectedLocation: event.location)));

    on<SubmitEventRequested>((event, emit) async {
      emit(state.copyWith(status: CreateEventStatus.loading));
      try {
        final fullDateTime = state.selectedDate.copyWith(
          hour: state.selectedTime.hour,
          minute: state.selectedTime.minute,
        );

        final newEvent = EventDM(
          title: event.title,
          description: event.description,
          category: event.categoryId,
          imagePath: " ",
          dateTime: fullDateTime,
          lat: state.selectedLocation?.latitude,
          lng: state.selectedLocation?.longitude,
          createdById: UserDM.currentUser!.id,
        );

        await FirestoreService.addEvent(newEvent);
        emit(state.copyWith(status: CreateEventStatus.success));
      } catch (e) {
        emit(state.copyWith(status: CreateEventStatus.failure, errorMessage: e.toString()));
      }
    });
  }
}