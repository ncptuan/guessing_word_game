import 'package:auto_route/auto_route.dart';
import 'package:guess_word_game/route/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: WelcomeRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: ChatRoute.page,
        ),
      ];
}
