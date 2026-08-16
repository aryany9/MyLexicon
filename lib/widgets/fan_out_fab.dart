import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/models/app_feature.dart';
import '../core/providers/feature_flags_provider.dart';
import '../models/lexicon_type.dart';

class FanOutFab extends ConsumerStatefulWidget {
  const FanOutFab({super.key});

  @override
  ConsumerState<FanOutFab> createState() => _FanOutFabState();
}

class _FanOutFabState extends ConsumerState<FanOutFab>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: _isOpen ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
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
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _onOptionTap(LexiconType type) {
    _toggle();
    context.push('/entry-form?type=${type.name}');
  }

  @override
  Widget build(BuildContext context) {
    final flags = ref.watch(featureFlagsProvider);

    final allOptions = [
      (
        feature: AppFeature.quote,
        label: 'Add Quote',
        icon: Icons.format_quote,
        color: Colors.purple,
        type: LexiconType.quote,
      ),
      (
        feature: AppFeature.idiom,
        label: 'Add Idiom',
        icon: Icons.auto_awesome,
        color: Colors.orange,
        type: LexiconType.idiom,
      ),
      (
        feature: AppFeature.phrase,
        label: 'Add Phrase',
        icon: Icons.chat_bubble_outline,
        color: Colors.teal,
        type: LexiconType.phrase,
      ),
      (
        feature: AppFeature.word,
        label: 'Add Word',
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
        onPressed: () => context.push('/entry-form'),
        elevation: 4,
        child: const Icon(Icons.add),
      );
    }

    return Stack(
      alignment: Alignment.bottomRight,
      clipBehavior: Clip.none,
      children: [
        if (_isOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggle,
              behavior: HitTestBehavior.opaque,
              child: Container(color: Colors.transparent),
            ),
          ),
        Column(
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
            const SizedBox(height: 8),
            FloatingActionButton(
              onPressed: _toggle,
              elevation: 4,
              child: AnimatedRotation(
                turns: _isOpen ? 0.125 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ],
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
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
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
