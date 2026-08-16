import '../../../models/lexicon_type.dart';

/// Represents a toggleable app feature that can be enabled/disabled by the user.
enum AppFeature {
  word,
  phrase,
  idiom,
  quote,
  collections;

  /// Returns the display label for this feature.
  String get label {
    switch (this) {
      case AppFeature.word:
        return 'Words';
      case AppFeature.phrase:
        return 'Phrases';
      case AppFeature.idiom:
        return 'Idioms';
      case AppFeature.quote:
        return 'Quotes';
      case AppFeature.collections:
        return 'Collections';
    }
  }

  /// The SharedPreferences key for persisting this feature flag.
  String get prefKey => 'feature_$name';

  /// Returns the corresponding [LexiconType] for category features.
  /// Returns null for [AppFeature.collections].
  LexiconType? get lexiconType {
    switch (this) {
      case AppFeature.word:
        return LexiconType.word;
      case AppFeature.phrase:
        return LexiconType.phrase;
      case AppFeature.idiom:
        return LexiconType.idiom;
      case AppFeature.quote:
        return LexiconType.quote;
      case AppFeature.collections:
        return null;
    }
  }

  /// All features that correspond to a [LexiconType] (i.e., the category features).
  static List<AppFeature> get categoryFeatures =>
      [AppFeature.word, AppFeature.phrase, AppFeature.idiom, AppFeature.quote];
}
