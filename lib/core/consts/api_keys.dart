/// API keys configuration.
///
/// You can provide the Gemini API key either by passing:
/// `--dart-define=GEMINI_API_KEY=your_key_here`
/// or by replacing the placeholder [_hardcodedGeminiKey] below.
class ApiKeys {
  static const String _envGeminiKey = String.fromEnvironment('GEMINI_API_KEY');

  /// Set your Gemini API key here if not passing via `--dart-define`.
  static const String _hardcodedGeminiKey = '';

  /// Returns the configured Gemini API key, preferring `--dart-define`.
  static String get geminiApiKey {
    if (_envGeminiKey.trim().isNotEmpty) {
      return _envGeminiKey.trim();
    }
    return _hardcodedGeminiKey.trim();
  }

  /// Whether a valid Gemini API key is configured.
  static bool get hasGeminiKey => geminiApiKey.isNotEmpty;
}

