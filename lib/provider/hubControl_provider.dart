import 'dart:async';
import 'package:hub_control/model/hub_user.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../model/time.dart';

class HubControlDbProvider {
  HubControlDbProvider._();
  static final HubControlDbProvider db = HubControlDbProvider._();
  static  Database? _database;

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await openDatabase(
      join(await getDatabasesPath(), 'HubControl.db'),
      onConfigure: _onConfigure,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE Schedule(StTime INTEGER PRIMARY KEY, ComfortSetting TEXT,userCode TEXT, FOREIGN KEY(userCode) REFERENCES Hubs (PairCode) )',
        );
        //region fill Schedule table with data

        //endregion
        await db.execute(
          'CREATE TABLE Hubs(PairCode VARCHAR PRIMARY KEY, UserName TEXT)',
        );
        //region fill Hubs table with data
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["VUBEKO",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["8DUY5D",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["0OK155",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["CTTD52",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["RARFP1",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["GY38JC",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["17373N",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["5WB5RK",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["CMGRR4",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["TNK3ED",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["7N4TYC",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["XJYRJ6",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["7MXIYI",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["WBOQ6M",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["F6JWPN",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["F8770W",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["GP65CF",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["O70VC1",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["3ZQSWZ",null]);
        await db
            .execute("INSERT INTO Hubs ('PairCode', 'UserName') values (?,?)", ["EAOTU8",null]);
        //endregion
      },
      version: 1,
    );
    return _database!;
  }

  Future<void> insertTime(Time t) async {
    final db = await database;
    await db.insert(
      'Schedule',
      t.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> clearDb() async {
    final db = await database;
    await db.rawDelete("DELETE FROM Schedule");


  }
  Future<void> updateUserName(String pairCode, String newName) async {
    final db = await database;

    await db.rawUpdate('''
    UPDATE Hubs 
    SET UserName = ?
    WHERE PairCode = ?
    ''',
        [newName,pairCode]);
  }


  Future<List<Time>> getAllTimes() async {
  // Get a reference to the database.
  final db = await database;
  SharedPreferences s = await SharedPreferences.getInstance();
  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = 
  await db.rawQuery("SELECT StTime, ComfortSetting, userCode FROM Schedule WHERE  userCode LIKE ? ",
  [s.getString("PairCode")]);

  return List.generate(maps.length, (i) {
    return Time( stTime: maps[i]['StTime'], comfortSetting: maps[i]['ComfortSetting'],userPairCode: maps[i]['userCode']);
  }
  );
  }
  Future<List<HubUser>> getAllHubs() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('Hubs');

    return List.generate(maps.length, (i) {
      return HubUser(pairCode: maps[i]['PairCode'], userName: maps[i]['UserName']);
    }
    );
  }
}