import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class GeminiService {
  late final GenerativeModel _model;
  late final ChatSession _chat;

  static const _systemPrompt = '''
You are GooglePro AI, a helpful assistant embedded in the GooglePro remote screen sharing app.
You help users with:
- Setting up and managing remote screen sharing sessions
- Troubleshooting connection issues  
- Configuring parental controls and screen time
- Understanding security features
- File transfers and remote control
- App settings and preferences

Keep answers concise, practical, and friendly. 
If asked about technical issues, provide step-by-step guidance.
Always prioritize user privacy and security in your recommendations.
''';

  GeminiService() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: AppConstants.geminiApiKey,
      generationConfig: GenerationConfig(temperature: 0.7, maxOutputTokens: 800),
      systemInstruction: Content.system(_systemPrompt),
    );
    _chat = _model.startChat();
  }

  Future<String> sendMessage(String userMessage) async {
    try {
      AppLogger.info('Gemini: sending message');
      final response = await _chat.sendMessage(Content.text(userMessage));
      final text = response.text ?? 'Sorry, I could not generate a response.';
      AppLogger.debug('Gemini: received ${text.length} chars');
      return text;
    } catch (e, s) {
      AppLogger.error('Gemini API failed', e, s);
      return 'I\'m having trouble connecting right now. Please check your internet connection and try again.';
    }
  }

  Future<String> analyzeDeviceIssue(String issueDescription) async {
    final prompt = 'As a device troubleshooting expert for the GooglePro app, analyze this issue and provide a solution:\n\n$issueDescription';
    return sendMessage(prompt);
  }

  Future<String> suggestConnectionSettings(Map<String, dynamic> networkInfo) async {
    final prompt = 'Based on this network info, suggest optimal connection settings for screen sharing:\n${networkInfo.toString()}';
    return sendMessage(prompt);
  }

  void resetChat() {
    _chat.history.clear();
  }
}
