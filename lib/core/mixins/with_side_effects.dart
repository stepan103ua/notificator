import 'package:notificator/domain/entities/side_effect.dart';

mixin WithSideEffects<State, S extends SideEffect> {
  Iterable<S> get sideEffects;

  State onSideEffectsUpdated(Iterable<S> sideEffects);

  State pushSideEffect(S sideEffect) =>
      onSideEffectsUpdated([...sideEffects, sideEffect]);

  State removeSideEffect(S sideEffect) {
    final sideEffects =
        this.sideEffects.where((element) => element != sideEffect);
    return onSideEffectsUpdated(sideEffects);
  }
}
