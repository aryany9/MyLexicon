import 'package:mylexicon/l10n/app_localizations.dart';
import 'package:mylexicon/core/models/app_feature.dart';

extension AppFeatureL10n on AppFeature {
  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case AppFeature.word:
        return l10n.typeWords;
      case AppFeature.quote:
        return l10n.typeQuotes;
      case AppFeature.phrase:
        return l10n.typePhrases;
      case AppFeature.idiom:
        return l10n.typeIdioms;
      case AppFeature.collections:
        return l10n.collections;
    }
  }
}
