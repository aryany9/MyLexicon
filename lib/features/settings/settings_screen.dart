import 'package:mylexicon/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'sub_pages/appearance_settings_page.dart';
import 'sub_pages/navigation_settings_page.dart';
import 'sub_pages/tags_settings_page.dart';
import 'sub_pages/data_settings_page.dart';
import 'sub_pages/about_settings_page.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String? _version;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      if (mounted) setState(() => _version = info.version);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
        appBar: AppBar(title: Text(l10n.settings)),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: [
            ListTile(
              leading: Icon(Icons.palette_outlined),
              title: Text(l10n.appearance),
              subtitle: Text(l10n.appearanceSubtitle),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AppearanceSettingsPage(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.tune_outlined),
              title: Text(l10n.navigationAndFeatures),
              subtitle: Text(l10n.navigationSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const NavigationSettingsPage(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.sell_outlined),
              title: Text(l10n.tags),
              subtitle: Text(l10n.tagsSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TagsSettingsPage(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.storage_outlined),
              title: Text(l10n.data),
              subtitle: Text(l10n.dataSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DataSettingsPage(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: Text(l10n.about),
              subtitle: Text(
                _version != null
                    ? l10n.aboutSubtitleWithVersion(_version!)
                    : l10n.aboutSubtitle,
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AboutSettingsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
