import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mylexicon/l10n/app_localizations.dart';
import '../../../../core/providers/locale_preference_provider.dart';

class LanguageSettingsPage extends ConsumerWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localePreferenceProvider);

    final options = [
      (code: 'system', label: l10n.systemDefault, subtitle: ''),
      (code: 'en', label: 'English', subtitle: ''),
      (code: 'uk', label: 'Українська', subtitle: 'Ukrainian'),
      (code: 'ru', label: 'Русский', subtitle: 'Russian'),
      (code: 'fa', label: 'فارسی', subtitle: 'Persian'),
      (code: 'hi', label: 'हिन्दी', subtitle: 'Hindi'),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        } else {
          context.go('/');
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.language)),
        body: RadioGroup<String>(
          groupValue: currentLocale,
          onChanged: (value) {
            if (value != null) {
              ref.read(localePreferenceProvider.notifier).setLocale(value);
            }
          },
          child: ListView(
            children: options.map((opt) {
              return RadioListTile<String>(
                value: opt.code,
                title: Text(opt.label),
                subtitle: opt.subtitle.isNotEmpty ? Text(opt.subtitle) : null,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
