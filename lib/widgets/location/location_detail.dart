import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/fab_bottom_app_bar.dart';
import 'package:flutter_app/widgets/layout.dart';
import 'package:flutter_app/model/location.dart';

class LocationDetailPage extends StatefulWidget {
  final LocationClass item;
  LocationDetailPage({Key key, this.item}) : super(key: key);

  @override
  _LocationDetailPageState createState() => _LocationDetailPageState();
}

class _LocationDetailPageState extends State<LocationDetailPage> {
  int photoindex = 0;
  List<String> photos = [
    "images/flutter1.png",
    "images/Logomark.png",
    "images/google1.png",
    "images/dart.png",
    "images/bird.jpg"
  ];

  final facilityData = ["Meeting Room", "Lesehan", "Saung", "Teras", "Toilet", "Musholla"];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double c_width = MediaQuery.of(context).size.width * 0.6;
    final _markDownData = facilityData.map((x) => "- $x\n").reduce((x, y) => "$x$y");

    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.item.location_name}",
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
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 110.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(photos[photoindex]),
                        fit: BoxFit.scaleDown)),
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            '${widget.item.location_name}',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                        Container(
                          width: c_width,
                          child: Text(
                            '${widget.item.location_description}',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        width: 50.0,
                        height: 40.0,
                        child: new LayoutBuilder(builder: (context, constraint) {
                          return new Icon(Icons.map, size: constraint.biggest.height);
                        }),
                      ),
                      Container(
                        child: Text(
                          'View Map',
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                              fontSize: 11.0),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
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
                            color: Colors.black,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.all(10.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat',
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
          Container(
            margin: EdgeInsets.all(10.0),
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Facilities',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            _markDownData,
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                fontSize: 11.0),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  height: 100,
                  child: new LayoutBuilder(builder: (context, constraint) {
                    return new Icon(Icons.call, size: constraint.biggest.height);
                  }),
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'Order',
        color: Colors.grey,
        selectedColor: Colors.red,
        notchedShape: CircularNotchedRectangle(),
        items: [
          FABBottomAppBarItem(
              iconData: Icons.menu, text: 'Home', page: 'homepage', index : 0),
          FABBottomAppBarItem(
              iconData: Icons.location_on, text: 'Location', page: 'location', index : 0),
          FABBottomAppBarItem(
              iconData: Icons.person, text: 'About Us', page: 'accountpage', index : 0),
          FABBottomAppBarItem(
              iconData: Icons.local_phone, text: 'Reservation', page: 'reservation', index : 0),
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
          Navigator.of(context).pushNamed("/category");
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}
