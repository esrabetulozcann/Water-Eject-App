import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit({required this.totalPages, int initialPage = 0})
    : pageController = PageController(initialPage: initialPage),
      super(initialPage);

  final int totalPages;
  final PageController pageController;

  bool get isFirstPage => state == 0;
  bool get isLastPage => state == totalPages - 1;

  Future<void> nextPage() async {
    if (isLastPage) return;
    await pageController.animateToPage(
      state + 1,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
    emit(state + 1);
  }

  Future<void> previousPage() async {
    if (isFirstPage) return;
    await pageController.animateToPage(
      state - 1,
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOut,
    );
    emit(state - 1);
  }

  Future<void> goToPage(int page) async {
    if (page < 0 || page >= totalPages) return;
    await pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
    emit(page);
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
