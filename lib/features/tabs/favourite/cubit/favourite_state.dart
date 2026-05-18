part of 'favourite_cubit.dart';
enum FavoriteStatus { initial, loading, success, failure }

class FavoriteState {
  final FavoriteStatus status;
  final List<EventDM> allFavorites;
  final List<EventDM> filteredFavorites;
  final String searchQuery;
  final String? errorMessage;

  FavoriteState({
    this.status = FavoriteStatus.initial,
    this.allFavorites = const [],
    this.filteredFavorites = const [],
    this.searchQuery = "",
    this.errorMessage,
  });

  FavoriteState copyWith({
    FavoriteStatus? status,
    List<EventDM>? allFavorites,
    List<EventDM>? filteredFavorites,
    String? searchQuery,
    String? errorMessage,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      allFavorites: allFavorites ?? this.allFavorites,
      filteredFavorites: filteredFavorites ?? this.filteredFavorites,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}