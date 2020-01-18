import 'dart:async';

import 'package:path/path.dart';
import 'package:flutter_app/model/order.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String tableName = "orders";

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, "resto.db");

    var OrdersDatabase = await openDatabase(dbPath, version: 1, onCreate: _createDb);
    return OrdersDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    var query = 'CREATE TABLE $tableName('
        'order_id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'quantity_order INTEGER, '
        'order_date TEXT, '
        'product_id INTEGER, '
        'product_name TEXT, '
        'category_id INTEGER,'
        'product_description TEXT, '
        'product_image, TEXT, '
        'product_price INTEGER'
        ')';
    await db.execute(query);
  }

  // Fetch Operation: Get all Order objects from database
  Future<List<Map<String, dynamic>>> getOrderMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $OrderTable order by $colPriority ASC');
    var result = await db.query(tableName);
    return result;
  }

  Future<int> addToCart(OrderClass order) async {
    Future<OrderClass> data = getOrderRowDataList(order.product_id, "product_id");

    data.then((data) {
      int quantity_order = data.quantity_order + 1;
      var orders = OrderClass(
        order_id: data.order_id,
        order_date: data.order_date,
        quantity_order : quantity_order,
        product_id: data.product_id,
        product_name: data.product_name,
        category_id: data.category_id,
        product_description: data.product_description,
        product_image: data.product_image,
        product_price: data.product_price,
      );
      updateOrder(orders);
    },onError: (error){
      insertOrder(order);
    });
  }

  // Insert Operation: Insert a Order object to database
  Future<int> insertOrder(OrderClass order) async {
    Database db = await this.database;

    var table = await db.rawQuery("SELECT MAX(order_id)+1 as order_id FROM $tableName");
    int order_id = table.first["order_id"];
    int result = await db.rawInsert(
        "INSERT Into $tableName (order_id, quantity_order, order_date, product_id, product_name, category_id, product_description, product_image, product_price)"
            " VALUES (?,?,?,?,?,?,?,?,?)",
        [order_id, order.quantity_order, order.order_date, order.product_id, order.product_name, order.category_id, order.product_description, order.product_image, order.product_price]);

    return result;
    //var result = await db.insert(tableName, order.toMap());
  }

  // Update Operation: Update a Order object and save it to database
  Future<int> updateOrder(OrderClass order) async {
    print(order.toMap());
    var db = await this.database;
    int result = await db.update(tableName, order.toMap(), where: 'order_id = ?', whereArgs: [order.order_id]);
    return result;
  }

  // Delete Operation: Delete a Order object from database
  Future<int> deleteOrder(int order_id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $tableName WHERE order_id = $order_id');
    return result;
  }

  // Get number of Order objects in database
  Future<OrderClass> getOrderRowDataList(int fieldValue, String fieldName) async {
    Database db = await this.database;
    var res = await  db.query("$tableName", where: "$fieldName = ?", whereArgs: [fieldValue]);
    return res.isNotEmpty ? OrderClass.fromJson(res.first) : Null ;
  }

  // Get number of Order objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    int result = 0;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $tableName');
    result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Order List' [ List<Order> ]
  Future<List<OrderClass>> getOrderList() async {

    var orderMapList = await getOrderMapList(); // Get 'Map List' from database
    int count = orderMapList.length;         // Count the number of map entries in db table

    List<OrderClass> orderList = List<OrderClass>();
    // For loop to create a 'Order List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      orderList.add(OrderClass.fromJson(orderMapList[i]));
    }

    return orderList;
  }




}
