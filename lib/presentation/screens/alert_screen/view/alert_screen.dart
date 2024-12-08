import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notificator/domain/usecases/get_notification_by_id_use_case.dart';
import 'package:notificator/presentation/screens/alert_screen/cubit/alert_cubit.dart';

class AlertScreen extends StatelessWidget {
  static const routeName = '/alert';

  final int id;

  const AlertScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AlertCubit(
          id: id,
          getNotificationByIdUseCase:
              context.read<GetNotificationByIdUseCase>(),
        ),
        child: Scaffold(
          appBar: AppBar(),
          body: BlocBuilder<AlertCubit, AlertState>(
            builder: (context, state) {
              if (state.notification == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Center(
                child: Column(
                  children: [
                    Text(
                      state.notification!.title,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.notification!.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
}
