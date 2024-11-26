part of 'native_event_cubit.dart';

class NativeEventState extends Equatable
    with WithSideEffects<NativeEventState, NativeEventSideEffect> {
  const NativeEventState({required this.sideEffects});

  @override
  NativeEventState onSideEffectsUpdated(
    Iterable<NativeEventSideEffect> sideEffects,
  ) =>
      NativeEventState(sideEffects: sideEffects);

  @override
  List<Object?> get props => [sideEffects];

  @override
  final Iterable<NativeEventSideEffect> sideEffects;
}
