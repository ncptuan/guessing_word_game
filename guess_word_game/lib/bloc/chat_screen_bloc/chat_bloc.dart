import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guess_word_game/constant.dart';
import 'package:guess_word_game/core/core.dart';
import 'package:guess_word_game/models/model.dart';
import 'package:guess_word_game/services/services.dart';

class ChatBloc extends BaseCubit<ChatDataModel, ChatDataParam> {
  ChatBloc(this.chatScreenService)
      : super(
          InitState(),
          model: ChatDataModel(
            secretWord: "",
            resultCorrectFromBE: [],
            resultPresentFromBE: [],
            message: [],
            textController: TextEditingController(),
          ),
          param: ChatDataParam(
            guessWord: "",
            wordLength: 5,
            seed: 1,
          ),
        );

  final ChatScreenService chatScreenService;

  @override
  Future<void> initState() async {
    Random random = Random();
    do {
      model?.resultCorrectFromBE = [];
      model?.resultPresentFromBE = [];
      param?.seed = (random.nextInt(100) + 1);
      await findApiResult();
    } while (
        (model?.resultPresentFromBE.length ?? 1) != (param?.wordLength ?? 1));
    if ((model?.resultCorrectFromBE.length ?? 1) < (param?.wordLength ?? 1)) {
      await shuffle();
    }
    model?.resultCorrectFromBE
        .sort((a, b) => (a.slot ?? 0).compareTo((b.slot ?? 1)));
    model?.secretWord = model?.resultCorrectFromBE
            .map((word) => (word.guess ?? ""))
            .toList()
            .join() ??
        "work";
    emit(LoadedState(model, param));
  }

  void sendMessage(String text) {
    if (text.isEmpty) return;
    model?.message.insert(0, {"user": text});
    model?.textController.clear();
    model?.numberOfGuess++;
    checkGuess(text);
    emit(LoadedState(model, param));
  }

  void checkGuess(String guess) {
    if (guess.toLowerCase() == model?.secretWord.toLowerCase()) {
      final botResponse =
          "Correct! The word was '${model?.secretWord}'. You guessed it in ${model?.numberOfGuess} attempts!";
      model?.message.insert(0, {"bot": botResponse});
      model?.isUserWin = true;

      return;
    } else {
      if ((model?.numberOfGuess ?? 1) >= 3) {
        _giveHint();
      } else {
        const botResponse = "Incorrect guess. Try again!";
        model?.message.insert(0, {"bot": botResponse});
      }
      emit(LoadedState(model, param));
      return;
    }
  }

  void _giveHint() {
    String botResponse;
    if (model?.numberOfGuess == 3) {
      botResponse = "Hint: The word starts with '${model?.secretWord[0]}'.";
    } else if (model?.numberOfGuess == 5) {
      botResponse =
          "Hint: The word end with '${model?.secretWord[((model?.resultCorrectFromBE.length ?? 0) - 1)]}'.";
    } else {
      botResponse = "You're getting closer!";
    }
    model?.message.insert(0, {"bot": botResponse});
    emit(LoadedState(model, param));
  }

//  Handle auto detach guess word from API
  Future<void> shuffle() async {
    final listPresent = model?.resultPresentFromBE ?? [];
    final listCorrect = model?.resultCorrectFromBE ?? [];
    do {
      listPresent.shuffle();
      List<String> presentWords =
          listPresent.map((word) => (word.guess ?? "")).toList();
      final decodeToString = presentWords.join();
      final backEndResult = await sendGuessWordToBE(
        word: decodeToString,
        length: (param?.wordLength ?? 5),
        seed: (param?.seed ?? 1),
      );
      for (var element in backEndResult) {
        bool isAdd = true;
        for (var i = 0; i < listCorrect.length; i++) {
          if ((element.slot == listCorrect[i].slot) ||
              element.result != ResultWordEnum.correct) {
            isAdd = false;
            break;
          }
        }
        if (isAdd && (element.result == ResultWordEnum.correct)) {
          model?.resultCorrectFromBE.add(element);
        }
      }
    } while (
        (model?.resultCorrectFromBE.length ?? 1) < (param?.wordLength ?? 1));
  }

  Future<void> findApiResult() async {
    for (var i = 0; i < 26; i++) {
      final int position = i * (param?.wordLength ?? 1);
      if (position > 26) {
        break;
      }
      final guessWord = autoGenGuessWord(position);
      print(guessWord);
      if (guessWord.isNotEmpty) {
        final decodeToString = guessWord.join();
        final backEndResult = await sendGuessWordToBE(
          word: decodeToString,
          length: (param?.wordLength ?? 5),
          seed: (param?.seed ?? 1),
        );
        if (backEndResult.isNotEmpty) {
          backEndResult.forEach((element) {
            if (element.result != ResultWordEnum.absent) {
              if (!(model?.resultPresentFromBE.contains(element) ?? true)) {
                model?.resultPresentFromBE.add(element);
              }
            }
            if (element.result == ResultWordEnum.correct) {
              model?.resultCorrectFromBE.add(element);
            }
          });
        }
      }
    }
  }

  List<String> autoGenGuessWord(int position) {
    final List<String> listTemplateWord = Constant.listTemplateWord;
    final endPosition = position + (param?.wordLength ?? 1);
    List<String> getListGuess = [];
    for (var i = position; i < listTemplateWord.length; i++) {
      if (i >= endPosition) {
        break;
      }
      getListGuess.add(listTemplateWord[i]);
    }
    while (getListGuess.length < (param?.wordLength ?? 0)) {
      getListGuess.add("z");
    }
    return getListGuess;
  }

  Future<List<RandomWordResponse>> sendGuessWordToBE({
    required String word,
    required int length,
    required int seed,
  }) async {
    final response = await chatScreenService.guessRandomWord(
        word: word, length: length, seed: seed);
    return response;
  }
}
