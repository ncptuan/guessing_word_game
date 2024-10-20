import 'package:flutter/material.dart';
import 'package:guess_word_game/models/reponse_model_data/reponse_model_data.dart';

class ChatDataModel {
  String secretWord;
  List<RandomWordResponse> resultCorrectFromBE;
  List<RandomWordResponse> resultPresentFromBE;
  List<Map<String, String>> message;
  int numberOfGuess;
  TextEditingController textController;
  bool isUserWin;

  ChatDataModel({
    required this.message,
    this.secretWord = "",
    this.numberOfGuess = 0,
    required this.resultCorrectFromBE,
    required this.resultPresentFromBE,
    required this.textController,
    this.isUserWin = false,
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
