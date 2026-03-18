import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/lifecycle/app_initializer.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() async {
  await AppInitializer.init();
  runApp(const GoogleProApp());
}

class GoogleProApp extends StatelessWidget {
  const GoogleProApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: const [],
      child: MaterialApp.router(
        title: 'GooglePro',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
