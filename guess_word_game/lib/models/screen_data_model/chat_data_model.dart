class ChatDataModel {
  String secretWord;
  ChatDataModel({
    this.secretWord = "",
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
