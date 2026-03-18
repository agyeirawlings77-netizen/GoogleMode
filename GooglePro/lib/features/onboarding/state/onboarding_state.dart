import 'package:equatable/equatable.dart';
abstract class OnboardingState extends Equatable {
  const OnboardingState();
  @override List<Object?> get props => [];
}
class OnboardingInitial extends OnboardingState { const OnboardingInitial(); }
class OnboardingPageChanged extends OnboardingState {
  final int currentPage; final int totalPages;
  const OnboardingPageChanged({required this.currentPage, required this.totalPages});
  @override List<Object?> get props => [currentPage];
  bool get isLastPage => currentPage == totalPages - 1;
}
class OnboardingComplete extends OnboardingState { const OnboardingComplete(); }
