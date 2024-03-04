import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notificator/core/database/database_provider.dart';
import 'package:notificator/core/dependencies/dependencies_provider.dart';
import 'package:notificator/core/routes/router.dart';
import 'package:notificator/core/ui_events_handler/ui_events_handler_cubit.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await DatabaseProvider.initDatabase();

  runApp(MyApp(db: db));
}

const platform = MethodChannel('com.example.notificator');

Future<void> invokeKotlinMethod() async {
  try {
    await platform.invokeMethod('schedule', {
      'time': DateTime.now().add(const Duration(seconds: 5)).millisecondsSinceEpoch,
      'message': 'test'
    });
  } on PlatformException catch (e) {
    print('Error: ${e.message}');
  }
}

class MyApp extends StatelessWidget {
  final Database db;

  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => UiEventsHandlerCubit(),
        child: DependenciesProvider(
          database: db,
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
