import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notificator/core/database/database_provider.dart';
import 'package:notificator/core/dependencies/dependencies_provider.dart';
import 'package:notificator/core/routes/router.dart';
import 'package:notificator/core/ui_events_handler/ui_events_handler_cubit.dart';
import 'package:notificator/presentation/widgets/native_event_handler/native_event_cubit.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await DatabaseProvider.initDatabase();

  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final Database db;

  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) =>
      DependenciesProvider(
        database: db,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => UiEventsHandlerCubit(),
            ),
            BlocProvider(
              create: (context) => NativeEventCubit(nativeEventsRepository: context.read()),
            ),
          ],
          child: MaterialApp.router(
            title: 'Notificator',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            routerConfig: CustomRouter().router,
          ),
        ),
      );
}
