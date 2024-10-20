import 'package:flutter/material.dart';
import 'package:guess_word_game/app_dependencies.dart';
import 'package:guess_word_game/route/route.dart';

Future<void> main() async {
  await initApp();
  runApp(const MyApp());
}

Future<bool> initApp() async {
  try {
    await AppDependencies.initDependencies();
    return true;
  } catch (e) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter.config(),
    );
  }
}
