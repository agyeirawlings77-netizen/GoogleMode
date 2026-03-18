import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FadeTransitionPage extends CustomTransitionPage {
  FadeTransitionPage({required super.child, super.key}) : super(
    transitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondary, child) =>
      FadeTransition(opacity: animation, child: child));
}

class SlideTransitionPage extends CustomTransitionPage {
  SlideTransitionPage({required super.child, super.key}) : super(
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondary, child) =>
      SlideTransition(position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)), child: child));
}
