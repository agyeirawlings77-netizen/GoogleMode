import 'package:injectable/injectable.dart'; import '../model/ai_context.dart'; @singleton class AiContextProvider { AiContext getContext() => const AiContext(); }
