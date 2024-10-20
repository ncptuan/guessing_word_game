import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_word_game/bloc/chat_screen_bloc/chat_screen_bloc.dart';
import 'package:guess_word_game/models/screen_data_model/screen_data_model.dart';

import '../../app_dependencies.dart';
import '../../core/core.dart';
import '../../widget/widget.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  final int wordLength;
  const ChatScreen({super.key, required this.wordLength});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatBloc bloc = AppDependencies.injector.get<ChatBloc>();

  @override
  void initState() {
    super.initState();
    bloc.param?.wordLength = widget.wordLength;
    bloc.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, BaseState>(
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

    return Scaffold(
      appBar: AppBar(
        title: Text(model.secretWord),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: model.message.length,
              reverse: true,
              itemBuilder: (context, index) {
                final message = model.message[index];
                return ListTile(
                  title: Text(message.keys.first == 'user'
                      ? "You: ${message['user']}"
                      : "Bot: ${message['bot']}"),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: model.textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your guess...',
                    ),
                  ),
                ),
                (model.isUserWin)
                    ? IconButton(
                        icon: const Icon(Icons.done),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          bloc.sendMessage(model.textController.text);
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
