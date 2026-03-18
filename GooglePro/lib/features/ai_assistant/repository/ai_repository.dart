abstract class AiRepository {
  Future<String> sendMessage(String message);
  Future<void> clearHistory();
  Future<String> analyzeIssue(String issue);
}
