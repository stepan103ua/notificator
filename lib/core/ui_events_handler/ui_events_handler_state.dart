part of 'ui_events_handler_cubit.dart';

class UiEventsHandlerState extends Equatable
    with WithSideEffects<UiEventsHandlerState, UiEventSideEffects> {
  @override
  final Iterable<UiEventSideEffects> sideEffects;

  const UiEventsHandlerState(this.sideEffects);

  @override
  UiEventsHandlerState onSideEffectsUpdated(
    Iterable<UiEventSideEffects> sideEffects,
  ) =>
      UiEventsHandlerState(sideEffects);

  @override
  List<Object?> get props => [sideEffects];
}
