import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notificator/core/ui_events_handler/ui_events_handler.dart';
import 'package:notificator/presentation/screens/alert_screen/view/alert_screen.dart';
import 'package:notificator/presentation/screens/new_notification_screen/view/new_notification_screen.dart';
import 'package:notificator/presentation/screens/notifications_screen/view/notifications_screen.dart';
import 'package:notificator/presentation/widgets/native_event_handler/view/native_event_handler.dart';

typedef ScreenBuilder = Widget Function();

class CustomRouter {
  final _routes = [
    GoRoute(
      name: NotificationsScreen.routeName,
      path: NotificationsScreen.routeName,
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      name: NewNotificationScreen.routeName,
      path: NewNotificationScreen.routeName,
      builder: (context, state) => const NewNotificationScreen(),
    ),
    GoRoute(
      name: AlertScreen.routeName,
      path: AlertScreen.routeName,
      builder: (context, state) => AlertScreen(id: state.extra as int),
    ),
  ];

  late final router = GoRouter(
    initialLocation: NotificationsScreen.routeName,
    routes: _routes
        .map(
          (route) => GoRoute(
            path: route.path,
            builder: (context, state) => NativeEventHandler(
              child: UiEventsHandler(
                child: route.builder!(context, state),
              ),
            ),
          ),
        )
        .toList(),
  );
}
