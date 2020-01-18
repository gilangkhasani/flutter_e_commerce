import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/fab_bottom_app_bar.dart';
import 'package:flutter_app/widgets/layout.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_app/widgets/product/product_slide.dart';
import 'package:flutter_app/utils/database_order.dart';
import 'package:flutter_app/model/order.dart';

class Page extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<Page> with SingleTickerProviderStateMixin {
  Completer<GoogleMapController> _controller = Completer();
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;

  static const LatLng _center =
      const LatLng(-6.915074571375264, 107.60743618011475);

  MapType _currentMapType = MapType.normal;
  LatLng _lastMapPosition = _center;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  @override
  void initState() {}

  @override
  void dispose() {
    super.dispose();
  }

  int photoindex = 0;
  List<String> photos = [
    "images/flutter1.png",
    "images/Logomark.png",
    "images/google1.png",
    "images/dart.png",
    "images/bird.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    //getCountData();

    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Image(
          image: AssetImage(
            "images/flutter1.png",
          ),
          height: 30.0,
          fit: BoxFit.fitHeight,
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
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
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                height: 110.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(photos[photoindex]),
                        fit: BoxFit.cover)),
              ),
            ],
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
                            'Best Menu',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                        ),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                          child: GestureDetector(
                              child: Text(
                                'View All',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed("/category");
                              }),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 160,
                    child: ProductSlide('search={"category_id":1}'),
                  )
                ],
              )),
          SizedBox(
            height: 2.0,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.grey)]),
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                          child: Text(
                            'Location',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                        ),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                    mapType: _currentMapType,
                    onCameraMove: _onCameraMove,
                  ),
                ],
              ))
        ],
      ),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'Order',
        color: Colors.grey,
        selectedColor: Colors.red,
        notchedShape: CircularNotchedRectangle(),
        items: [
          FABBottomAppBarItem(
              iconData: Icons.menu, text: 'Home', page: 'homepage', index: 1),
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
          //Navigator.of(context).pushNamed("/category");
          Navigator.pushNamed(context, '/category');
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }

  void getCountData() {
    var dbFuture = databaseHelper.initializeDatabase();
    Future<int> res = databaseHelper.getCount();
    res.then((count) {
      setState(() {
        this.count = count;
      });
    });
  }
}
