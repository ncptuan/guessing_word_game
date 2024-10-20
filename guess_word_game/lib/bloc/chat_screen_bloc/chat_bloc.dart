import 'package:guess_word_game/app_dependencies.dart';
import 'package:guess_word_game/core/core.dart';
import 'package:guess_word_game/models/model.dart';
import 'package:guess_word_game/models/screen_data_model/screen_data_model.dart';
import 'package:guess_word_game/services/services.dart';

class ChatBloc extends BaseCubit<ChatDataModel, ChatDataParam> {
  ChatBloc(this.chatScreenService)
      : super(
          InitState(),
          model: ChatDataModel(
            secretWord: "",
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
    // TODO: implement initState
    final value = await sendGuessWordToBE(
      word: "guess",
      length: param?.wordLength ?? 5,
      seed: param?.seed ?? 1,
    );
    emit(LoadedState(model, param));
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
