import 'package:injectable/injectable.dart';
import '../service/gemini_service.dart';
@injectable
class AnalyzeDeviceUsecase {
  final GeminiService _svc;
  AnalyzeDeviceUsecase(this._svc);
  Future<String> call(String issue) => _svc.analyzeDeviceIssue(issue);
}
