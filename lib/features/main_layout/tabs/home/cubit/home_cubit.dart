import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../../DM/eventDM.dart';
import '../../../../../core/firebase_service/firestore/firestore_service.dart';

part 'home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  StreamSubscription? _eventsSubscription;

  void getEvents(String categoryId, int index) {
    emit(state.copyWith(status: HomeStatus.loading, selectedCategoryIndex: index));

    _eventsSubscription?.cancel();

    _eventsSubscription = FirestoreService.getEventsStream(categoryId).listen(
          (events) {
        emit(state.copyWith(status: HomeStatus.success, events: events));
      },
      onError: (error) {
        emit(state.copyWith(status: HomeStatus.failure, errorMessage: error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _eventsSubscription?.cancel();
    return super.close();
  }
}