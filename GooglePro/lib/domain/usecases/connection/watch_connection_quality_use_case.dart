import 'package:injectable/injectable.dart'; @injectable class WatchConnectionQualityUseCase { Stream<double> call() => Stream.periodic(const Duration(seconds: 3), (_) => 95.0); }
