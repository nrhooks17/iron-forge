// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseProgressAdapter extends TypeAdapter<ExerciseProgress> {
  @override
  final int typeId = 3;

  @override
  ExerciseProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseProgress(
      exerciseName: fields[0] as String,
      targetSets: fields[1] as int,
      targetReps: fields[2] as int,
      completedSets: (fields[3] as List).cast<bool>(),
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseProgress obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.exerciseName)
      ..writeByte(1)
      ..write(obj.targetSets)
      ..writeByte(2)
      ..write(obj.targetReps)
      ..writeByte(3)
      ..write(obj.completedSets);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
