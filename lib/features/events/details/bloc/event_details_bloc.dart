import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/firebase_service/firestore/firestore_service.dart';



part 'event_details_event.dart';
part 'event_details_state.dart';

class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  EventDetailsBloc() : super(EventDetailsState()) {
    on<DeleteEventRequested>((event, emit) async {
      emit(state.copyWith(status: EventDetailsStatus.deleting));
      try {
        await FirestoreService.deleteEvent(event.eventId);
        await FirestoreService.removeEventFromFav(event.eventId);
        emit(state.copyWith(status: EventDetailsStatus.success));
      } catch (e) {
        emit(state.copyWith(status: EventDetailsStatus.failure, errorMessage: e.toString()));
      }
    });
  }
}
