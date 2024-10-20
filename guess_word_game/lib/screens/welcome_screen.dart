import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_word_game/app_dependencies.dart';
import 'package:guess_word_game/bloc/welcome_screen_bloc/welcome_screen_bloc.dart';
import 'package:guess_word_game/core/core.dart';
import 'package:guess_word_game/models/screen_data_model/welcome_data_model.dart';
import 'package:guess_word_game/route/router.gr.dart';

import '../widget/widget.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final WelcomeBloc bloc = AppDependencies.injector.get<WelcomeBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: bloc,
      builder: (context, state) {
        if (state is LoadedState) {
          return buildContent(context, state);
        } else {
          return const CustomLoadingWidget();
        }
      },
      listener: (context, state) {},
    );
  }

  Widget buildContent(BuildContext context, LoadedState state) {
    final model = state.model as WelcomeDataModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Guessing Game"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to the Word Guessing Game",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Select to length of the word to guess (1-6)",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Slider(
              value: model.selectWordLength.toDouble(),
              min: 1,
              max: 6,
              divisions: 5,
              onChanged: (double value) {
                bloc.onChangeWordLenth(value.toInt());
              },
            ),
            Text(
              "Selected length: ${model.selectWordLength}",
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).push(
                  ChatRoute(wordLength: model.selectWordLength),
                );
              },
              child: const Text(
                "Start game",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
