import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notificator/core/ui_events_handler/ui_events_handler_cubit.dart';
import 'package:notificator/domain/entities/notification.dart' as entity;

import '../cubit/notifications_cubit.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notifications';

  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => NotificationsCubit(
          getNotificationsUseCase: context.read(),
          updateNotificationUseCase: context.read(),
          openScreenCallback: context.read<UiEventsHandlerCubit>(),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notifications'),
          ),
          body: BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) => switch (state) {
              NotificationsLoaded _ =>
                _LoadedState(notifications: state.notifications),
              NotificationsLoading _ =>
                const Center(child: CircularProgressIndicator()),
              NotificationsError _ => const Center(child: Text('Error')),
            },
          ),
        ),
      );
}

class _LoadedState extends StatelessWidget {
  const _LoadedState({required this.notifications});

  final Iterable<entity.Notification> notifications;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          MaterialButton(
            onPressed:
                context.read<NotificationsCubit>().onCreateNotificationClicked,
            child: const Text('Create notification'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) => _NotificationItem(
                notification: notifications.elementAt(index),
                onActivityChanged: () => context
                    .read<NotificationsCubit>()
                    .onNotificationActivityChanged(index),
              ),
            ),
          ),
        ],
      );
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({
    required this.notification,
    required this.onActivityChanged,
  });

  final entity.Notification notification;
  final VoidCallback onActivityChanged;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('hh:mm').format(notification.date),
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('dd MMM yyyy').format(notification.date),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Switch.adaptive(
                value: notification.isActive,
                onChanged: (_) => onActivityChanged(),
              ),
            ],
          ),
        ),
      );
}
