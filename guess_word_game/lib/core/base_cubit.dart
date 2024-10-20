import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:guess_word_game/core/base_state.dart';

abstract class BaseCubit<M, P> extends Cubit<BaseState> {
  BaseCubit(super.state, {this.model, this.param});

  M? model;
  P? param;

  void initState();

  void showLoading() => EasyLoading.show();

  void dismissLoading() => EasyLoading.dismiss();
}
