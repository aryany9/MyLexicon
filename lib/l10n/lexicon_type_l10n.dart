import 'package:mylexicon/l10n/app_localizations.dart';
import 'package:mylexicon/models/lexicon_type.dart';

extension LexiconTypeL10n on LexiconType {
  String localizedSingular(AppLocalizations l10n) {
    switch (this) {
      case LexiconType.word:
        return l10n.typeWord;
      case LexiconType.quote:
        return l10n.typeQuote;
      case LexiconType.phrase:
        return l10n.typePhrase;
      case LexiconType.idiom:
        return l10n.typeIdiom;
    }
  }

  String localizedPlural(AppLocalizations l10n) {
    switch (this) {
      case LexiconType.word:
        return l10n.typeWords;
      case LexiconType.quote:
        return l10n.typeQuotes;
      case LexiconType.phrase:
        return l10n.typePhrases;
      case LexiconType.idiom:
        return l10n.typeIdioms;
    }
  }

  String localizedBadge(AppLocalizations l10n) {
    return localizedSingular(l10n).toUpperCase();
  }
}
