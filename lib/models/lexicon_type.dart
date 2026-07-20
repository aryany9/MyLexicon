import 'package:hive/hive.dart';

part 'lexicon_type.g.dart';

@HiveType(typeId: 2)
enum LexiconType {
  @HiveField(0)
  word,
  @HiveField(1)
  quote,
  @HiveField(2)
  phrase,
  @HiveField(3)
  idiom,
}
