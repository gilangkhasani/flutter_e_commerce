import 'dart:async';

import 'package:path/path.dart';
import 'package:flutter_app/model/Customer.dart';
import 'package:sqflite/sqflite.dart';

class DbCustomer {
  DbCustomer._();

  static final DbCustomer db = DbCustomer._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "Customer.db");
    return await openDatabase(dbPath, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Customer ("
              "id INTEGER PRIMARY KEY,"
              "first_name TEXT,"
              "last_name TEXT,"
              "email TEXT"
              ")");
        });
  }

  insertCust(Customer cust) async {
    final db = await database;
    print(cust);
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Customer");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Customer (id,first_name,last_name,email)"
            " VALUES (?,?,?,?)",
        [id, cust.firstName, cust.lastName, cust.email]);
    return raw;
  }

  updateCustomer(Customer cust) async {
    final db = await database;
    var res = await db.update("Customer", cust.toMap(),
        where: "id = ?", whereArgs: [cust.id]);
    return res;
  }

  getCustomer(int id) async {
    final db = await database;
    var res = await db.query("Customer", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Customer.fromJson(res.first) : null;
  }

  Future<List<Customer>> getAllCustomers() async {
    final db = await database;
    var res = await db.query("Customer");
    List<Customer> list =
    res.isNotEmpty ? res.map((c) => Customer.fromJson(c)).toList() : [];
    return list;
  }

  deleteCustomer(int id) async {
    final db = await database;
    return db.delete("Customer", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Customer");
  }
}