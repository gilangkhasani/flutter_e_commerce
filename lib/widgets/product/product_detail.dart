import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/product/product_slide.dart';
import 'package:flutter_app/model/product.dart';
import 'package:flutter_app/utils/database_order.dart';
import 'package:flutter_app/model/order.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/utils/utility.dart';

class ProductDetail extends StatefulWidget {
  final ProductClass item;
  ProductDetail({Key key, this.item}) : super(key: key);

  @override
  _productDetailState createState() => _productDetailState();
}

class _productDetailState extends State<ProductDetail>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback _showPersBottomSheetCallBack;
  int qty = 1;

  @override
  void initState() {
    super.initState();
    _showPersBottomSheetCallBack = _showBottomSheet;
  }

  void _showBottomSheet() {
    setState(() {
      _showPersBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState
        .showBottomSheet((context) {
          return new Container(
            height: 300.0,
            color: Colors.tealAccent,
            child: new Center(
                //child: new Text("Hi BottomSheet"),
                ),
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showPersBottomSheetCallBack = _showBottomSheet;
            });
          }
        });
  }

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              child: Container(
                  color: Colors.white,
                  child: Column(children: [
                    Stack(children: [
                      Container(
                        width: double.infinity,
                        height: 56.0,
                        child: Center(
                            child: Text(
                                widget.item.product_name) // Your desired title
                            ),
                      ),
                      Positioned(
                          right: 0.0,
                          top: 0.0,
                          child: IconButton(
                              icon: Icon(Icons.close), // Your desired icon
                              onPressed: () {
                                Navigator.of(context).pop();
                              }))
                    ]),
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      height: 150.0,
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                              image: new NetworkImage(
                                  "https://itbsjabartsel.com/resto/assets/images/" +
                                      widget.item.product_image),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Text("Quantity"),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: new BoxDecoration(
                                color: Colors.pinkAccent,
                                border: new Border.all(
                                    color: Colors.white, width: 2.0),
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
                                      setState(() {
                                        if (qty > 1) {
                                          qty--;
                                        } else {
                                          //openDialog(context, order);
                                        }
                                      });
                                    },
                                  ))),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            child: Text(
                              "${qty}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Quicksand',
                                  fontSize: 18),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: new BoxDecoration(
                                color: Colors.pinkAccent,
                                border: new Border.all(
                                    color: Colors.white, width: 2.0),
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
                                        qty++;
                                      });
                                    },
                                  ))),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      child: new SizedBox(
                        width: double.infinity,
                        // height: double.infinity,
                        child: new RaisedButton(
                          onPressed: () {
                            DateTime now = DateTime.now();
                            String formattedDate =
                                DateFormat('yyyy-MM-dd – kk:mm').format(now);

                            var order = OrderClass(
                              order_id: 0,
                              order_date: formattedDate,
                              quantity_order: qty,
                              product_id: widget.item.product_id,
                              product_name: widget.item.product_name,
                              category_id: widget.item.category_id,
                              product_description: widget.item.product_description,
                              product_image: widget.item.product_image,
                              product_price: widget.item.product_price,
                            );

                            _save(context, order);
                          },
                          splashColor: Colors.pinkAccent,
                          color: Colors.pink,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.card_travel,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  "ADD TO CART",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ])));
        });
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.9;
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.item.product_name}",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.grey,
            onPressed: () {
              //Navigator.of(context).pushReplacementNamed("/homepage");
              Navigator.pop(context);
            }),
      ),
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                height: 150.0,
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: new NetworkImage(
                            "https://itbsjabartsel.com/resto/assets/images/" +
                                widget.item.product_image),
                        fit: BoxFit.cover)),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 0.0, 10.0, 0.0),
            child: Text(
              'Rp. ' + widget.item.product_price.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            //height: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.grey)]),
            child: Column(children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                      child: Text(
                        'Description',
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: c_width,
                margin: EdgeInsets.all(10.0),
                child: Text(
                  "${widget.item.product_description}",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.grey)]),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                          child: Text(
                            'Related Product',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 160,
                    child: ProductSlide('search={"category_id":' +
                        widget.item.category_id.toString() +
                        '}'),
                  )
                ],
              )),
          SizedBox(
            height: 2.0,
          ),
        ],
      ),
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
            child: RaisedButton(
              onPressed: () {
                DateTime now = DateTime.now();
                String formattedDate =
                    DateFormat('yyyy-MM-dd – kk:mm').format(now);

                var order = OrderClass(
                  order_id: 0,
                  order_date: formattedDate,
                  quantity_order: 1,
                  product_id: widget.item.product_id,
                  product_name: widget.item.product_name,
                  category_id: widget.item.category_id,
                  product_description: widget.item.product_description,
                  product_image: widget.item.product_image,
                  product_price: widget.item.product_price,
                );

                _save(context, order);
                //_showModalSheet();
              },
              splashColor: Colors.pinkAccent,
              color: Colors.pink,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.card_travel,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "ADD TO CART",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _save(BuildContext context, OrderClass order) async {
    DatabaseHelper databaseHelper = new DatabaseHelper();
    databaseHelper.initializeDatabase();
    int result = 0;
    List<OrderClass> cart;

    result = await databaseHelper.addToCart(order);
    Utility.snackShowCart(context, order.product_name + ' Has add to Cart');
  }
}
