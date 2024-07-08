import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notificator/core/utils/method_channel_handler.dart';
import 'package:notificator/data/datasources/notifications_dao.dart';
import 'package:notificator/data/repositories/notifications_repository.dart';
import 'package:notificator/domain/repositories/notifications_repository.dart';
import 'package:notificator/domain/usecases/get_notifications_use_case.dart';
import 'package:notificator/domain/usecases/save_notification_use_case/save_notification_use_case.dart';
import 'package:notificator/domain/usecases/update_notification_use_case.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class DependenciesProvider extends StatelessWidget {
  const DependenciesProvider({
    super.key,
    required this.child,
    required this.database,
  });

  final Database database;
  final Widget child;

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (_) => const MethodChannel('com.example.notificator'),
          ),
          RepositoryProvider(
            create: (context) => MethodChannelHandler(platform: context.read()),
          ),
          RepositoryProvider(create: (_) => const Uuid()),
          RepositoryProvider(create: (_) => database),
          RepositoryProvider(
            create: (context) => NotificationsDao(database: context.read()),
          ),
          RepositoryProvider<NotificationsRepository>(
            create: (context) => NotificationsRepositoryImpl(
              notificationsDao: context.read(),
            ),
          ),
          RepositoryProvider(
            create: (context) => GetNotificationsUseCase(
              notificationRepository: context.read(),
            ),
          ),
          RepositoryProvider(
            create: (context) => UpdateNotificationUseCase(
              notificationRepository: context.read(),
            ),
          ),
          RepositoryProvider(
            create: (context) => SaveNotificationUseCase(
              notificationRepository: context.read(),
              methodChannelHandler: context.read(),
              uuid: context.read(),
            ),
          ),
        ],
        child: child,
      );
}
