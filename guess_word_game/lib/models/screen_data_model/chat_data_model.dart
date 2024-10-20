import 'package:guess_word_game/models/reponse_model_data/reponse_model_data.dart';

class ChatDataModel {
  String secretWord;
  List<RandomWordResponse> resultCorrectFromBE;
  List<RandomWordResponse> resultPresentFromBE;
  ChatDataModel({
    this.secretWord = "",
    required this.resultCorrectFromBE,
    required this.resultPresentFromBE,
  });
}

class ChatDataParam {
  String guessWord;
  int wordLength;
  int seed;
  ChatDataParam({
    this.guessWord = "",
    this.wordLength = 5,
    this.seed = 1,
  });
}
