import 'package:equatable/equatable.dart';
import 'package:notificator/domain/entities/side_effect.dart';

sealed class UiEventSideEffects extends Equatable implements SideEffect {
  const UiEventSideEffects();

  @override
  List<Object?> get props => [];
}

class UiEventOpenScreen extends UiEventSideEffects {
  final String screenName;
  final Object? arguments;

  const UiEventOpenScreen(this.screenName, [this.arguments]);

  @override
  List<Object?> get props => [screenName, arguments];
}

class UiEventPopScreen extends UiEventSideEffects {
  const UiEventPopScreen();
}

class UiEventShowSnackBar extends UiEventSideEffects {
  final String message;

  const UiEventShowSnackBar(this.message);

  @override
  List<Object?> get props => [message];
}
