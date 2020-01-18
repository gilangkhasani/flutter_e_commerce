import 'package:flutter/material.dart';
import 'package:flutter_app/utils/database_order.dart';
import 'package:flutter_app/model/order.dart';
import 'package:flutter_app/utils/utility.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartPage extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<CartPage> with SingleTickerProviderStateMixin {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<OrderClass> orderList;
  int count = 0;
  int sumTotal = 0;

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      new CartPage();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (orderList == null) {
      orderList = List<OrderClass>();
      getListData();
    }

    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.grey,
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: RefreshIndicator(
          child: getOrderListView(context), onRefresh: refreshList),
      bottomNavigationBar: Builder(
        builder: (context) => _buildBottomNavigationBar(context),
      ),
    );
  }

  _buildBottomNavigationBar(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text("Total \n Rp. " + sumTotal.toString()),
                )),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 5.0, 5.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/checkout");
                  },
                  color: Colors.pinkAccent,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            )
          ],
        ));
  }

  ListView getOrderListView(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    //this.sumTotal = 0;
    int total = 0;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int counter) {
        total =  (this.orderList[counter].quantity_order * this.orderList[counter].product_price);
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: new Slidable(
            delegate: new SlidableDrawerDelegate(),
            actionExtentRatio: 0.25,
            child: new Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  width: 120.0,
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          image: new NetworkImage(
                              "https://itbsjabartsel.com/resto/assets/images/" +
                                  this.orderList[counter].product_image),
                          fit: BoxFit.cover)),
                  height: 120.0,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        margin: EdgeInsets.all(5.0),
                        child: Text(
                          this.orderList[counter].product_name,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.all(5.0),
                                decoration: new BoxDecoration(
                                  color: Colors.pinkAccent,
                                  border: new Border.all(color: Colors.white, width: 2.0),
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: SizedBox(
                                    height: 22.0,
                                    width: 22.0,
                                    child: new IconButton(
                                      padding: new EdgeInsets.all(0.0),
                                      icon: new Icon(Icons.remove, size: 22.0),
                                      color: Colors.white,
                                      onPressed: () {
                                        var order = OrderClass(
                                          order_id: orderList[counter].order_id,
                                          order_date:
                                              orderList[counter].order_date,
                                          quantity_order:
                                              orderList[counter].quantity_order,
                                          product_id:
                                              orderList[counter].product_id,
                                          product_name:
                                              orderList[counter].product_name,
                                          category_id:
                                              orderList[counter].category_id,
                                          product_description:
                                              orderList[counter]
                                                  .product_description,
                                          product_image:
                                              orderList[counter].product_image,
                                          product_price:
                                              orderList[counter].product_price,
                                        );
                                        setState(() {
                                          if (orderList[counter]
                                                  .quantity_order >
                                              1) {
                                            orderList[counter].quantity_order--;
                                            _save(context, order, counter);
                                          } else {
                                            openDialog(context, order);
                                          }
                                        });
                                      },
                                    ))),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              child: Text(
                                "${orderList[counter].quantity_order}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Quicksand',
                                  fontSize: 18
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.all(5.0),
                                decoration: new BoxDecoration(
                                  color: Colors.pinkAccent,
                                  border: new Border.all(color: Colors.white, width: 2.0),
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: SizedBox(
                                    height: 22.0,
                                    width: 22.0,
                                    child: new IconButton(
                                      padding: new EdgeInsets.all(0.0),
                                      icon: new Icon(Icons.add, size: 22.0),
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          orderList[counter].quantity_order++;
                                          var order = OrderClass(
                                            order_id:
                                                orderList[counter].order_id,
                                            order_date:
                                                orderList[counter].order_date,
                                            quantity_order: orderList[counter]
                                                .quantity_order,
                                            product_id:
                                                orderList[counter].product_id,
                                            product_name:
                                                orderList[counter].product_name,
                                            category_id:
                                                orderList[counter].category_id,
                                            product_description:
                                                orderList[counter]
                                                    .product_description,
                                            product_image: orderList[counter]
                                                .product_image,
                                            product_price: orderList[counter]
                                                .product_price,
                                          );
                                          _save(context, order, counter);
                                        });
                                      },
                                    ))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        margin: EdgeInsets.all(5.0),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          "Rp. ${total}",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Quicksand',
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            secondaryActions: <Widget>[
              new IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => openDialog(context, orderList[counter]),
              ),
            ],
          ),
        );
      },
    );
  }

  void openDialog(BuildContext context, OrderClass order){
    var dialog = AlertDialog(
      title: Text('Remove this Items?'),
      content: const Text(
          'This will remove your item from your cart.'),
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop(
                ConfirmAction.CANCEL);
          },
        ),
        FlatButton(
          child: const Text('YES'),
          onPressed: () {
            _delete(context, order);
            Navigator.of(context).pop(
                ConfirmAction.ACCEPT);
          },
        )
      ],
    );
    Utility.openDialog(context, dialog);
  }

  void _delete(BuildContext context, OrderClass order) async {
    int result = await databaseHelper.deleteOrder(order.order_id);
    if (result != 0) {
      Utility.snackBarMessage(context, 'Item Deleted !!!');
      getListData();
    }
  }

  void _save(BuildContext context, OrderClass order, int counter) async {
    int result = await databaseHelper.updateOrder(order);
    getSumTotal();
  }

  void getListData() {
    var dbFuture = databaseHelper.initializeDatabase();
    Future<List<OrderClass>> noteListFuture = databaseHelper.getOrderList();
    noteListFuture.then((orderList) {
      setState(() {
        this.orderList = orderList;
        this.count = orderList.length;
        getSumTotal();
      });
    });
  }

  void getSumTotal(){
    var dbFuture = databaseHelper.initializeDatabase();
    Future<List<OrderClass>> noteListFuture = databaseHelper.getOrderList();
    noteListFuture.then((orderList) {
      setState(() {
        this.sumTotal = 0;
        for(var i = 0; i < orderList.length; i++){
          this.sumTotal += (this.orderList[i].quantity_order * this.orderList[i].product_price);
        }
      });
    });
  }
}
