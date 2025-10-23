import 'package:bloc/bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  static const int totalPages = 3;

  void nextPage() {
    if (state < totalPages - 1) {
      emit(state + 1);
    }
  }

  void previousPage() {
    if (state > 0) {
      emit(state - 1);
    }
  }

  void goToPage(int page) {
    if (page >= 0 && page < totalPages) {
      emit(page);
    }
  }

  bool get isFirstPage => state == 0;
  bool get isLastPage => state == totalPages - 1;
}
