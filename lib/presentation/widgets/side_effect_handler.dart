import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notificator/core/mixins/with_side_effects.dart';
import 'package:notificator/domain/entities/side_effect.dart';

typedef OnSideEffectCallback = void Function(
  BuildContext context,
  SideEffect sideEffect,
);

class SideEffectHandler<B extends BlocBase<S>, S extends WithSideEffects>
    extends StatelessWidget {
  const SideEffectHandler({
    Key? key,
    required this.child,
    required this.onSideEffect,
  }) : super(key: key);

  final Widget child;
  final OnSideEffectCallback onSideEffect;

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      listener: (context, state) {
        for (var sideEffect in state.sideEffects) {
          onSideEffect(context, sideEffect);
          context.read<B>().emit(state.removeSideEffect(sideEffect));
        }
      },
      child: child,
    );
  }
}
