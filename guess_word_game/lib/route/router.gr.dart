// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:guess_word_game/screens/chat_screen.dart' as _i1;
import 'package:guess_word_game/screens/welcome_screen.dart' as _i2;

/// generated route for
/// [_i1.ChatScreen]
class ChatRoute extends _i3.PageRouteInfo<void> {
  const ChatRoute({List<_i3.PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.ChatScreen();
    },
  );
}

/// generated route for
/// [_i2.WelcomeScreen]
class WelcomeRoute extends _i3.PageRouteInfo<void> {
  const WelcomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.WelcomeScreen();
    },
  );
}
