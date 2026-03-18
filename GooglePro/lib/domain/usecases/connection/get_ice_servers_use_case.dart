import 'package:injectable/injectable.dart';
import '../../../../core/constants/app_constants.dart';
@injectable
class GetIceServersUseCase {
  List<Map<String, dynamic>> call() => [
    {'urls': AppConstants.stunUrl},
    {'urls': AppConstants.turnUrl, 'username': AppConstants.turnUsername, 'credential': AppConstants.turnPassword},
  ];
}
