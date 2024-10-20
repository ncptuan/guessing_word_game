abstract class BaseState {}

class InitState extends BaseState {}

class LoadingState extends BaseState {}

class LoadedState<TModel, TParam> extends BaseState {
  final TModel model;
  final TParam param;

  LoadedState(this.model, this.param);
}
