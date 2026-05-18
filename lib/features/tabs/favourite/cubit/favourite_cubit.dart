import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../DM/eventDM.dart';
import '../../../../../DM/userDM.dart';
import '../../../../../core/firebase_service/firestore/firestore_service.dart';


part 'favourite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState());

  StreamSubscription? _favoritesSubscription;

  void getFavorites() {
    if (UserDM.currentUser == null) return;

    emit(state.copyWith(status: FavoriteStatus.loading));

    _favoritesSubscription?.cancel();
    _favoritesSubscription = FirestoreService.getFavEventsStream(UserDM.currentUser!.id)
        .listen((events) {
      final filtered = _filterEvents(events, state.searchQuery);
      emit(state.copyWith(
        status: FavoriteStatus.success,
        allFavorites: events,
        filteredFavorites: filtered,
      ));
    }, onError: (error) {
      emit(state.copyWith(status: FavoriteStatus.failure, errorMessage: error.toString()));
    });
  }

  void search(String query) {
    final filtered = _filterEvents(state.allFavorites, query);
    emit(state.copyWith(searchQuery: query.toLowerCase(), filteredFavorites: filtered));
  }

  List<EventDM> _filterEvents(List<EventDM> events, String query) {
    if (query.isEmpty) return List.from(events);
    return events.where((e) => e.title.toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  Future<void> close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }
}