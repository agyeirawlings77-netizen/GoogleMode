import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../state/onboarding_state.dart';
class OnboardingCubit extends Cubit<OnboardingState> {
  final int totalPages;
  OnboardingCubit({this.totalPages = 4}) : super(const OnboardingInitial()) { emit(OnboardingPageChanged(currentPage: 0, totalPages: totalPages)); }
  void nextPage() { if (state is OnboardingPageChanged) { final s = state as OnboardingPageChanged; if (s.isLastPage) { complete(); return; } emit(OnboardingPageChanged(currentPage: s.currentPage + 1, totalPages: totalPages)); } }
  void previousPage() { if (state is OnboardingPageChanged) { final s = state as OnboardingPageChanged; if (s.currentPage > 0) emit(OnboardingPageChanged(currentPage: s.currentPage - 1, totalPages: totalPages)); } }
  void goToPage(int page) { if (page >= 0 && page < totalPages) emit(OnboardingPageChanged(currentPage: page, totalPages: totalPages)); }
  Future<void> complete() async { final prefs = await SharedPreferences.getInstance(); await prefs.setBool('onboarding_done', true); emit(const OnboardingComplete()); }
  static Future<bool> isComplete() async { final prefs = await SharedPreferences.getInstance(); return prefs.getBool('onboarding_done') ?? false; }
}
