// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'random_word_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RandomWordResponse _$RandomWordResponseFromJson(Map<String, dynamic> json) =>
    RandomWordResponse(
      guess: json['guess'] as String?,
      slot: (json['slot'] as num?)?.toInt(),
      result: $enumDecodeNullable(_$ResultWordEnumEnumMap, json['result']),
    );

Map<String, dynamic> _$RandomWordResponseToJson(RandomWordResponse instance) =>
    <String, dynamic>{
      'guess': instance.guess,
      'slot': instance.slot,
      'result': _$ResultWordEnumEnumMap[instance.result],
    };

const _$ResultWordEnumEnumMap = {
  ResultWordEnum.absent: 'absent',
  ResultWordEnum.present: 'present',
  ResultWordEnum.correct: 'correct',
};
