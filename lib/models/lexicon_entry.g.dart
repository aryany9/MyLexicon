// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lexicon_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LexiconEntryAdapter extends TypeAdapter<LexiconEntry> {
  @override
  final int typeId = 0;

  @override
  LexiconEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LexiconEntry(
      id: fields[0] as String,
      term: fields[1] as String,
      definition: fields[2] as String,
      type: fields[3] as LexiconType,
      example: fields[4] as String?,
      notes: fields[5] as String?,
      tags: (fields[6] as List).cast<String>(),
      collectionId: fields[7] as String?,
      isFavorite: fields[8] as bool,
      createdAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LexiconEntry obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.term)
      ..writeByte(2)
      ..write(obj.definition)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.example)
      ..writeByte(5)
      ..write(obj.notes)
      ..writeByte(6)
      ..write(obj.tags)
      ..writeByte(7)
      ..write(obj.collectionId)
      ..writeByte(8)
      ..write(obj.isFavorite)
      ..writeByte(9)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LexiconEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
