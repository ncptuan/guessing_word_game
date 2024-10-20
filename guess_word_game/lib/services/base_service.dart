import 'package:guess_word_game/app_dependencies.dart';

import '../network/netword.dart';

abstract class BaseService {
  final dio = AppDependencies.injector.get<BaseDio>();
}
