# AGENTS.md

This file documents project-specific conventions, rules, and gotchas for AI agents working on this repository. Read this before making any changes.

---

## Versioning

### pubspec.yaml version format
```
version: <semver>+<build>
```
Example: `version: 1.3.1+5`

### Version bump policy
- **Patch** (`x.x.N`) — bug fixes, UI polish, back-navigation fixes, dependency migrations
- **Minor** (`x.N.0`) — new user-facing features or settings sections
- **Major** — breaking architectural changes (rare)

### Pre-commit hook
A pre-commit hook enforces that bumping `version:` in `pubspec.yaml` **requires** a matching `CHANGELOG.md` entry. The commit will be blocked if `CHANGELOG.md` is not updated alongside the version bump.

---

## F-Droid versionCode Scheme

The app is published on F-Droid with **per-ABI APK splits**. F-Droid applies a `VercodeOperation` (defined in [`fdroiddata/metadata/com.aryanyadav.mylexicon.yml`](../fdroiddata/metadata/com.aryanyadav.mylexicon.yml)) that converts the pubspec build number into ABI-specific version codes:

| Formula | ABI | Example (build +5) |
|---|---|---|
| `buildNumber * 10 + 1` | armeabi-v7a | `51` |
| `buildNumber * 10 + 2` | arm64-v8a | `52` |
| `buildNumber * 10 + 3` | x86_64 | `53` |

### Fastlane changelogs
Fastlane changelogs live at:
```
fastlane/metadata/android/en-US/changelogs/<versionCode>.txt
```

**Always create three files** — one per ABI versionCode — when bumping the version. Never use the raw pubspec build number as the filename.

Example for `pubspec version: 1.3.1+5`:
- `51.txt` ← armeabi-v7a
- `52.txt` ← arm64-v8a
- `53.txt` ← x86_64

All three files should have identical content. Copy from one:
```bash
cp 51.txt 52.txt && cp 51.txt 53.txt
```

### F-Droid metadata file
Located at: `/Users/aryanyadav/Documents/Development/fdroiddata/metadata/com.aryanyadav.mylexicon.yml`

When a new release is ready, add three new `Builds` entries (one per ABI) with the correct `versionCode` and commit SHA.

---

## Android Manifest

### URL scheme queries (Android 11+)
`url_launcher` requires explicit `<queries>` entries in `AndroidManifest.xml` to resolve browser apps on Android 11+. These are already present:
```xml
<intent>
    <action android:name="android.intent.action.VIEW"/>
    <data android:scheme="https"/>
</intent>
<intent>
    <action android:name="android.intent.action.VIEW"/>
    <data android:scheme="http"/>
</intent>
```
Do **not** use `canLaunchUrl()` as a gate for plain `https://` URLs — call `launchUrl()` directly. `canLaunchUrl` is only meaningful for custom schemes like `tel:` or `mailto:`.

---

## Back Navigation

All non-dashboard screens must use `PopScope(canPop: false)` to intercept the Android back gesture and navigate to the dashboard (`context.go('/')`) instead of exiting the app.

**Rule**: "Till the time I am not back to the dashboard page, it should not exit."

### Pattern
```dart
return PopScope(
  canPop: false,
  onPopInvokedWithResult: (didPop, result) {
    if (didPop) return;
    context.go('/');
  },
  child: Scaffold(...),
);
```

### Settings screen exception
Settings sub-pages are pushed via `Navigator.of(context).push(MaterialPageRoute(...))` (inner navigator), so the Settings root must check `Navigator.of(context).canPop()` first before going to dashboard:
```dart
onPopInvokedWithResult: (didPop, result) {
  if (didPop) return;
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  } else {
    context.go('/');
  }
},
```

### Do NOT put PopScope on AppShell
Wrapping `AppShell` in `PopScope` breaks inner-navigator sub-pages (Settings sub-pages, etc.) by causing `NavigationNotification` collisions. Each screen handles its own back behaviour individually.

---

## Dialog Back Navigation (Android 14)

When showing confirmation dialogs inside screens that have `PopScope(canPop: false)`, always use:
```dart
showDialog(
  context: context,
  useRootNavigator: false, // ← required
  builder: ...
)
```

Without `useRootNavigator: false`, Android 14's predictive back gesture dismisses the dialog and then immediately triggers another back event that exits the screen, bypassing `PopScope`.

---

## Settings Architecture

Settings is split into sub-pages under `lib/features/settings/sub_pages/`:

| File | Purpose |
|---|---|
| `appearance_settings_page.dart` | Theme, density, AMOLED, tags/badge display |
| `navigation_settings_page.dart` | Startup tab, tab order, feature toggles |
| `tags_settings_page.dart` | Rename and delete tags |
| `data_settings_page.dart` | Export, import, clear data |
| `about_settings_page.dart` | App version, GitHub links, licenses, attribution |
| `theme_settings_page.dart` | Theme palette selection |

Sub-pages are pushed via `Navigator.of(context).push(MaterialPageRoute(...))` — **not** via `go_router` — so they sit on the inner navigator stack inside the shell route.

### Dynamic version display
The `SettingsScreen` and `AboutSettingsPage` both use `package_info_plus` (`PackageInfo.fromPlatform()`) to read the version dynamically. Never hardcode the version string in UI — it will fall out of sync.

---

## Dependencies

| Package | Purpose |
|---|---|
| `package_info_plus` | Read app version/build number at runtime |
| `url_launcher` | Open external URLs. Use `launchUrl()` directly for https links |
| `file_picker ^12` | v12 API: `saveFile` returns `Uri?`, `pickFiles` returns `List<PlatformFile>` |
| `go_router ^17` | Shell-based routing. Dashboard is `/`, other tabs are `/collections`, `/words`, `/phrases`, `/idioms`, `/quotes`, `/settings` |

---

## Commit Conventions

```
feat:   new user-facing feature
fix:    bug fix
chore:  version bump, changelog update, metadata, config
refactor: code restructure with no behaviour change
test:   adding or updating tests
```

Always update **both** `CHANGELOG.md` **and** the relevant fastlane changelogs (`51.txt`, `52.txt`, `53.txt`) when bumping the version.
