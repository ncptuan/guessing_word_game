import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_word_game/app_dependencies.dart';
import 'package:guess_word_game/bloc/chat_screen_bloc/chat_screen_bloc.dart';
import 'package:guess_word_game/models/screen_data_model/screen_data_model.dart';

import '../core/core.dart';
import '../widget/widget.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  final int wordLength;
  const ChatScreen({super.key, required this.wordLength});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatBloc bloc = AppDependencies.injector.get<ChatBloc>();

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
    final model = state.model as ChatDataModel;
    final param = state.param as ChatDataParam;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Guessing Game"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
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
          ],
        ),
      ),
    );
  }
}
