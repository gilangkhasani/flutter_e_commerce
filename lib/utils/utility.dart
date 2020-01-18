import 'package:flutter/material.dart';
import 'package:flutter_app/utils/database_order.dart';
import 'package:flutter_app/model/order.dart';
enum ConfirmAction { CANCEL, ACCEPT }
class Utility {

  static void showLoading(BuildContext context, bool flag) {
    if (flag) {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });
    }
  }

  static void showAlert(BuildContext context, String page, String text) {
    var alert = new AlertDialog(
      content: Container(
        child: Row(
          children: <Widget>[Text(text)],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () {
              if (page != '') {
                Navigator.popAndPushNamed(context, '/' + page);
              }
            },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.black),
            ))
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  static void openDialog(BuildContext context, AlertDialog dialog){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return dialog;
      }
    );
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context, AlertDialog dialog) async {
    return showDialog<ConfirmAction>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return dialog;
        }
    );
  }

  static void snackShowCart(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: 'View Cart',
        onPressed: () {
          // Some code to undo the change!
          Navigator.of(context).pushNamed("/cart");
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void snackBarMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),

    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static int getCountCartData() {
    DatabaseHelper databaseHelper = DatabaseHelper();
    Future<int> res = databaseHelper.getCount();
    res.then((count) {
      return count;
      //return orderList.length;
    });
  }
}
