import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/lexicon_type.dart';

enum SortOrder { newestFirst, oldestFirst, aToZ, zToA }

const _kSortOrderKeyPrefix = 'sort_order_';

final sortOrderProvider =
    StateNotifierProvider<SortOrderNotifier, Map<LexiconType, SortOrder>>((ref) {
  return SortOrderNotifier();
});

class SortOrderNotifier extends StateNotifier<Map<LexiconType, SortOrder>> {
  SortOrderNotifier()
      : super({
          LexiconType.word: SortOrder.newestFirst,
          LexiconType.quote: SortOrder.newestFirst,
          LexiconType.phrase: SortOrder.newestFirst,
          LexiconType.idiom: SortOrder.newestFirst,
        }) {
    _loadAll();
  }

  Future<void> _loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final updated = <LexiconType, SortOrder>{};
    for (final type in LexiconType.values) {
      final key = '$_kSortOrderKeyPrefix${type.name}';
      final stored = prefs.getString(key);
      updated[type] = _sortOrderFromString(stored) ?? SortOrder.newestFirst;
    }
    state = updated;
  }

  Future<void> setSortOrder(LexiconType type, SortOrder order) async {
    state = {...state, type: order};
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_kSortOrderKeyPrefix${type.name}', order.name);
  }

  SortOrder? _sortOrderFromString(String? value) {
    if (value == null) return null;
    for (final order in SortOrder.values) {
      if (order.name == value) return order;
    }
    return null;
  }
}
