import 'package:get_it/get_it.dart';
import 'package:guess_word_game/bloc/chat_screen_bloc/chat_screen_bloc.dart';
import 'package:guess_word_game/bloc/welcome_screen_bloc/welcome_screen_bloc.dart';

class BlocDependencies {
  static void init(GetIt injector) {
    injector.registerFactory<WelcomeBloc>(() => WelcomeBloc());
    injector.registerFactory<ChatBloc>(() => ChatBloc(injector()));
  }
}
