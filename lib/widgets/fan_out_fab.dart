import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/models/app_feature.dart';
import '../core/providers/feature_flags_provider.dart';
import '../l10n/app_localizations.dart';
import '../models/lexicon_type.dart';

class FanOutFab extends ConsumerStatefulWidget {
  const FanOutFab({super.key});

  @override
  ConsumerState<FanOutFab> createState() => _FanOutFabState();
}

class _FanOutFabState extends ConsumerState<FanOutFab>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  final _overlayController = OverlayPortalController();
  final _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    if (_overlayController.isShowing) {
      _overlayController.hide();
    }
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_isOpen) {
      _controller.reverse().then((_) {
        if (mounted) {
          _overlayController.hide();
          setState(() {
            _isOpen = false;
          });
        }
      });
      setState(() {
        _isOpen = false;
      });
    } else {
      setState(() {
        _isOpen = true;
      });
      _overlayController.show();
      _controller.forward();
    }
  }

  void _onOptionTap(LexiconType type) {
    if (_overlayController.isShowing) {
      _overlayController.hide();
    }
    _controller.reset();
    setState(() {
      _isOpen = false;
    });
    context.push('/entry-form?type=${type.name}');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final flags = ref.watch(featureFlagsProvider);

    final allOptions = [
      (
        feature: AppFeature.quote,
        label: l10n.addQuote,
        icon: Icons.format_quote,
        color: Colors.purple,
        type: LexiconType.quote,
      ),
      (
        feature: AppFeature.idiom,
        label: l10n.addIdiom,
        icon: Icons.auto_awesome,
        color: Colors.orange,
        type: LexiconType.idiom,
      ),
      (
        feature: AppFeature.phrase,
        label: l10n.addPhrase,
        icon: Icons.chat_bubble_outline,
        color: Colors.teal,
        type: LexiconType.phrase,
      ),
      (
        feature: AppFeature.word,
        label: l10n.addWord,
        icon: Icons.abc,
        color: Colors.blue,
        type: LexiconType.word,
      ),
    ];

    final visibleOptions =
        allOptions.where((opt) => flags[opt.feature] ?? true).toList();

    // Fallback: If no category features are enabled, render simple FAB to entry form.
    if (visibleOptions.isEmpty) {
      return FloatingActionButton(
        heroTag: null,
        tooltip: l10n.addEntry,
        onPressed: () => context.push('/entry-form'),
        elevation: 4,
        child: Icon(Icons.add),
      );
    }

    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) {
              if (!didPop && _isOpen) {
                _toggle();
              }
            },
            child: Stack(
              children: [
                // Full-screen backdrop blur and modal tap barrier
                Positioned.fill(
                  child: FadeTransition(
                    opacity: _expandAnimation,
                    child: GestureDetector(
                      key: ValueKey('fan_out_backdrop_barrier'),
                      onTap: _toggle,
                      behavior: HitTestBehavior.opaque,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.35),
                        ),
                      ),
                    ),
                  ),
                ),
                // Anchored fan-out buttons and close FAB
                Builder(
                  builder: (context) {
                    final isRtl = Directionality.of(context) == TextDirection.rtl;
                    final anchor = isRtl ? Alignment.bottomLeft : Alignment.bottomRight;
                    return CompositedTransformFollower(
                      link: _layerLink,
                      targetAnchor: anchor,
                      followerAnchor: anchor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ...visibleOptions.map(
                        (opt) => _buildOption(
                          context: context,
                          label: opt.label,
                          icon: opt.icon,
                          color: opt.color,
                          type: opt.type,
                        ),
                      ),
                      SizedBox(height: 8),
                      FloatingActionButton(
                        key: ValueKey('fan_out_close_fab'),
                        heroTag: null,
                        tooltip: l10n.cancel,
                        onPressed: _toggle,
                        elevation: 4,
                        child: AnimatedRotation(
                          turns: 0.125,
                          duration: Duration(milliseconds: 200),
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
              ],
            ),
          );
        },
        child: FloatingActionButton(
          key: ValueKey('fan_out_main_fab'),
          heroTag: null,
          tooltip: l10n.addEntry,
          onPressed: _toggle,
          elevation: 4,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color color,
    required LexiconType type,
  }) {
    return ScaleTransition(
      scale: _expandAnimation,
      child: FadeTransition(
        opacity: _expandAnimation,
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              FloatingActionButton.small(
                heroTag: 'fab_${type.name}',
                onPressed: () => _onOptionTap(type),
                backgroundColor: color,
                child: Icon(icon, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
