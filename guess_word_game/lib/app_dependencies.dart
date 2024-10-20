import 'package:get_it/get_it.dart';
import 'package:guess_word_game/bloc/bloc.dart';

class AppDependencies {
  AppDependencies._();

  static GetIt injector = GetIt.instance;

  static Future initDependencies() async {
    BlocDependencies.init(injector);
  }
}
