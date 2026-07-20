// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lexicon_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LexiconTypeAdapter extends TypeAdapter<LexiconType> {
  @override
  final int typeId = 2;

  @override
  LexiconType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LexiconType.word;
      case 1:
        return LexiconType.quote;
      case 2:
        return LexiconType.phrase;
      case 3:
        return LexiconType.idiom;
      default:
        return LexiconType.word;
    }
  }

  @override
  void write(BinaryWriter writer, LexiconType obj) {
    switch (obj) {
      case LexiconType.word:
        writer.writeByte(0);
        break;
      case LexiconType.quote:
        writer.writeByte(1);
        break;
      case LexiconType.phrase:
        writer.writeByte(2);
        break;
      case LexiconType.idiom:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LexiconTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
