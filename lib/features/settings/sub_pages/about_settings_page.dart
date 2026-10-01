import 'package:mylexicon/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSettingsPage extends StatefulWidget {
  const AboutSettingsPage({super.key});

  @override
  State<AboutSettingsPage> createState() => _AboutSettingsPageState();
}

class _AboutSettingsPageState extends State<AboutSettingsPage> {
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) setState(() => _packageInfo = info);
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }


  void _copyVersion() {
    if (_packageInfo == null) return;
    final l10n = AppLocalizations.of(context)!;
    final version = 'v${_packageInfo!.version}+${_packageInfo!.buildNumber}';
    Clipboard.setData(ClipboardData(text: version));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.versionCopied(version)),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final version = _packageInfo != null
        ? 'v${_packageInfo!.version} (build ${_packageInfo!.buildNumber})'
        : '—';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.about)),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8),
        children: [
          // App identity card
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Card(
              elevation: 0,
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Icon(
                        Icons.menu_book_rounded,
                        size: 36,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      l10n.appTitle,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    GestureDetector(
                      onLongPress: _copyVersion,
                      child: Text(
                        version,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      l10n.appTagline,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.links,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ),
          SizedBox(height: 4),

          ListTile(
            leading: Icon(Icons.code_rounded),
            title: Text(l10n.sourceCode),
            subtitle: Text(l10n.githubUrl),
            trailing: Icon(Icons.open_in_new, size: 18),
            onTap: () => _launchUrl('https://github.com/aryany9/MyLexicon'),
          ),
          ListTile(
            leading: Icon(Icons.bug_report_outlined),
            title: Text(l10n.reportBug),
            subtitle: Text(l10n.reportBugSubtitle),
            trailing: Icon(Icons.open_in_new, size: 18),
            onTap: () => _launchUrl(
                'https://github.com/aryany9/MyLexicon/issues/new'),
          ),
          ListTile(
            leading: Icon(Icons.star_outline_rounded),
            title: Text(l10n.starOnGithub),
            subtitle: Text(l10n.ifYouFindUseful),
            trailing: Icon(Icons.open_in_new, size: 18),
            onTap: () => _launchUrl('https://github.com/aryany9/MyLexicon'),
          ),

          Divider(indent: 16, endIndent: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              l10n.legal,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.description_outlined),
            title: Text(l10n.openSourceLicenses),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              showLicensePage(
                context: context,
                applicationName: l10n.appTitle,
                applicationVersion: _packageInfo != null
                    ? 'v${_packageInfo!.version}'
                    : '',
                applicationIcon: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.menu_book_rounded,
                    size: 48,
                    color: colorScheme.primary,
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 32),
          // Footer
          Column(
            children: [
              RichText(
                text: TextSpan(
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  children: [
                    TextSpan(text: l10n.madeWith),
                    TextSpan(
                      text: '♥',
                      style: TextStyle(color: colorScheme.error),
                    ),
                    TextSpan(text: l10n.inIndia),
                  ],
                ),
              ),
              SizedBox(height: 4),
              GestureDetector(
                onTap: () => _launchUrl('https://github.com/aryany9'),
                child: Text(
                  l10n.byAuthor,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
