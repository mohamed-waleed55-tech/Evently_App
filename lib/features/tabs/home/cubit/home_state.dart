part of 'home_cubit.dart';
enum HomeStatus { initial, loading, success, failure }

class HomeState {
  final HomeStatus status;
  final List<EventDM> events;
  final int selectedCategoryIndex;
  final String? errorMessage;

  HomeState({
    this.status = HomeStatus.initial,
    this.events = const [],
    this.selectedCategoryIndex = 0,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<EventDM>? events,
    int? selectedCategoryIndex,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      events: events ?? this.events,
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}