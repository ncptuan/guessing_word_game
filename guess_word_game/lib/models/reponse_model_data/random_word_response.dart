import 'package:json_annotation/json_annotation.dart';

import '../model.dart';

part 'random_word_response.g.dart';

@JsonSerializable()
class RandomWordResponse {
  String? guess;
  int? slot;
  ResultWordEnum? result;

  RandomWordResponse({
    this.guess,
    this.slot,
    this.result,
  });

  factory RandomWordResponse.fromJson(Map<String, dynamic> json) =>
      _$RandomWordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RandomWordResponseToJson(this);
}
