import 'package:get_it/get_it.dart';
import 'injection.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  await configureDependencies();
}

T get<T extends Object>() => sl<T>();
