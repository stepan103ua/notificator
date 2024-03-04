import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notificator/core/ui_events_handler/ui_events_handler_cubit.dart';
import 'package:notificator/core/ui_events_handler/ui_events_side_effects.dart';
import 'package:notificator/presentation/widgets/side_effect_handler.dart';

class UiEventsHandler extends StatelessWidget {
  const UiEventsHandler({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      SideEffectHandler<UiEventsHandlerCubit, UiEventsHandlerState>(
        onSideEffect: (context, sideEffect) =>
            switch (sideEffect as UiEventSideEffects) {
          final UiEventOpenScreen sideEffect => context.push(
              sideEffect.screenName,
              extra: sideEffect.arguments,
            ),
          UiEventPopScreen _ => context.pop(),
          final UiEventShowSnackBar sideEffect =>
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(sideEffect.message)),
            ),
        },
        child: child,
      );
}
