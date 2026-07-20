import 'package:hive/hive.dart';

part 'lexicon_collection.g.dart';

@HiveType(typeId: 1)
class LexiconCollection extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  int colorValue;

  @HiveField(4)
  final DateTime createdAt;

  LexiconCollection({
    required this.id,
    required this.name,
    this.description,
    required this.colorValue,
    required this.createdAt,
  });
}
