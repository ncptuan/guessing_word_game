import 'package:dio/dio.dart';
import 'package:guess_word_game/models/model.dart';
import 'package:guess_word_game/services/base_service.dart';

class ChatScreenService extends BaseService {
  Future<List<RandomWordResponse>> guessRandomWord({
    required String word,
    required int length,
    required int seed,
  }) async {
    try {
      final Response? response = await dio.request(
          method: Method.get,
          path: 'random?guess=$word&size=$length&seed=$seed');

      final responseStatusCode = response?.statusCode ?? 0;
      List<RandomWordResponse> listWord = [];
      if ((responseStatusCode >= 200) && (responseStatusCode < 300)) {
        listWord = ((response?.data ?? []) as List)
            .map((word) => RandomWordResponse.fromJson(word))
            .toList();
      }
      return listWord;
    } catch (e) {
      return [];
    }
  }
}
