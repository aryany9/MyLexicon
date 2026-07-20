import 'package:hive/hive.dart';
import 'lexicon_type.dart';

part 'lexicon_entry.g.dart';

@HiveType(typeId: 0)
class LexiconEntry extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String term;

  @HiveField(2)
  String definition;

  @HiveField(3)
  LexiconType type;

  @HiveField(4)
  String? example;

  @HiveField(5)
  String? notes;

  @HiveField(6)
  List<String> tags;

  @HiveField(7)
  String? collectionId;

  @HiveField(8)
  bool isFavorite;

  @HiveField(9)
  final DateTime createdAt;

  LexiconEntry({
    required this.id,
    required this.term,
    required this.definition,
    required this.type,
    this.example,
    this.notes,
    required this.tags,
    this.collectionId,
    required this.isFavorite,
    required this.createdAt,
  });
}
