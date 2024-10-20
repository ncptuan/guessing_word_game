import 'package:get_it/get_it.dart';
import 'package:guess_word_game/network/netword.dart';
import 'package:guess_word_game/services/chat_screen_service.dart';

class ServiceDependencies {
  static void init(GetIt injector) {
    injector.registerLazySingleton<BaseDio>(
        () => BaseDio("https://wordle.votee.dev:8000/"));

    injector
        .registerLazySingleton<ChatScreenService>(() => ChatScreenService());
  }
}
