# Fix Zoomed Android App Icon

The "zoomed in" effect on Android icons occurs because Android's **Adaptive Icons** require a specific "Safe Zone." The icon is 108x108 dp, but the content must stay within the center 72x72 dp (approx. 66%). If the foreground image fills the entire 108x108 dp canvas, the edges are cropped, making it look zoomed.

This plan uses the industry-standard `flutter_launcher_icons` package to regenerate the icons with correct padding and adaptive support.

## User Review Required

> [!IMPORTANT]
> This plan will regenerate the Android and iOS icons. I will use the existing `assets/icon.png` as the source.
> For the Android Adaptive Icon background, I'll use the brand color or a white background. Please let me know if you prefer a specific color.

## Proposed Changes

### Dependencies & Configuration

#### [MODIFY] [pubspec.yaml](file:///Users/aryanyadav/Documents/Development/Flutter/my_lexicon/pubspec.yaml)
Add `flutter_launcher_icons` to `dev_dependencies`.

#### [NEW] [flutter_launcher_icons.yaml](file:///Users/aryanyadav/Documents/Development/Flutter/my_lexicon/flutter_launcher_icons.yaml)
Create a configuration file to handle icon generation, specifically setting `adaptive_icon_foreground` with appropriate padding and `adaptive_icon_background`.

## Verification Plan

### Manual Verification
1. Run the generation command: `flutter pub run flutter_launcher_icons`
2. Build and run the app on an Android device/emulator: `flutter run`
3. Verify the icon appearance on the home screen.
