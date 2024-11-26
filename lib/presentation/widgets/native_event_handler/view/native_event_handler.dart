import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notificator/presentation/screens/alert_screen/view/alert_screen.dart';
import 'package:notificator/presentation/widgets/native_event_handler/native_event_cubit.dart';
import 'package:notificator/presentation/widgets/native_event_handler/native_event_side_effect.dart';
import 'package:notificator/presentation/widgets/side_effect_handler.dart';

class NativeEventHandler extends StatelessWidget {
  const NativeEventHandler({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      SideEffectHandler<NativeEventCubit, NativeEventState>(
        onSideEffect: (context, sideEffect) {
          if (sideEffect is NativeEventOpenAlarmScreen) {
            context.go(AlertScreen.routeName, extra: sideEffect.alarmId);
          }
        },
        child: child,
      );
}
