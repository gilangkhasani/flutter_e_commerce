import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/fab_bottom_app_bar.dart';
import 'package:flutter_app/widgets/layout.dart';
import 'package:flutter_app/widgets/category/category_list.dart';
import 'package:flutter_app/utils/utility.dart';
import 'package:flutter_app/utils/database_order.dart';
import 'package:flutter_app/model/order.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  int count;

  int photoindex = 0;
  List<String> photos = [
    "no_image.jpg",
    "special_hot_plate.jpg",
    "gallery_Aneka_Juice.jpg",
  ];

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      new CategoryPage();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    //getCountData();
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu Category",
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
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
                height: 150.0,
                width: 30.0,
                child: new GestureDetector(
                  onTap: () {
//                    Navigator.of(context).push(
//                        new MaterialPageRoute(
//                            builder:(BuildContext context) =>
//                            new CartItemsScreen()
//                        )
//                    );
                    Navigator.of(context).pushNamed("/cart");
                  },
                  child: new Stack(
                    children: <Widget>[
                      new IconButton(
                        icon: new Icon(
                          Icons.shopping_cart,
                          color: Colors.black,
                        ),
                        onPressed: null,
                      ),
                      count == 0
                          ? new Container()
                          : new Positioned(
                              child: new Stack(
                              children: <Widget>[
                                new Icon(Icons.brightness_1,
                                    size: 20.0, color: Colors.green[800]),
                                new Positioned(
                                    top: 3.0,
                                    right: 4.0,
                                    child: new Center(
                                      child: new Text(
                                        count.toString(),
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ],
                            )),
                    ],
                  ),
                )),
          )
        ],
      ),
      body: _bodyContent(),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'Order',
        color: Colors.grey,
        selectedColor: Colors.red,
        notchedShape: CircularNotchedRectangle(),
        items: [
          FABBottomAppBarItem(
              iconData: Icons.menu, text: 'Home', page: 'homepage', index: 0),
          FABBottomAppBarItem(
              iconData: Icons.location_on,
              text: 'Location',
              page: 'location',
              index: 0),
          FABBottomAppBarItem(
              iconData: Icons.person,
              text: 'About Us',
              page: 'accountpage',
              index: 0),
          FABBottomAppBarItem(
              iconData: Icons.local_phone,
              text: 'Reservation',
              page: 'reservation',
              index: 0),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(
          context), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _bodyContent() {
    return RefreshIndicator(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: new NetworkImage(
                              "https://itbsjabartsel.com/resto/assets/images/" +
                                  photos[0]),
                          fit: BoxFit.cover)),
                ),
              ],
            ),
            SizedBox(
              height: 2.0,
            ),
            Container(
              height: 800,
              width: double.infinity,
              child: CategoryList(),
            )
          ],
        ),
        onRefresh: refreshList);
  }

  Widget _buildFab(BuildContext context) {
    final icons = [Icons.sms, Icons.mail, Icons.phone];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
        );
      },
      child: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/category");
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }

  void getCountData() {

    DatabaseHelper databaseHelper = DatabaseHelper();
    var dbFuture = databaseHelper.initializeDatabase();
    Future<int> res = databaseHelper.getCount();
    res.then((count) {
      setState(() {
        this.count = count;
      });
    });
  }
}
