import 'package:notificator/data/datasources/notifications_dao.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseProvider {
  static const _dbPath = 'notificator.db';
  static const _dbVersion = 1;

  static Future<Database> initDatabase() => openDatabase(
        _dbPath,
        version: _dbVersion,
        onCreate: (Database db, int version) => db.execute(
          '''CREATE TABLE ${NotificationsDao.tableName} (
                id INTEGER PRIMARY KEY, 
                title TEXT, 
                description TEXT, 
                date TEXT, 
                isRepeating INTEGER,
                isActive INTEGER
              )''',
        ),
      );
}
