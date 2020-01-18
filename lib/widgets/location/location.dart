import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/fab_bottom_app_bar.dart';
import 'package:flutter_app/widgets/layout.dart';
import 'package:flutter_app/widgets/location/location_list.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  int photoindex = 0;
  List<String> photos = [
    "images/flutter1.png",
    "images/Logomark.png",
    "images/google1.png",
    "images/dart.png",
    "images/bird.jpg"
  ];

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      new LocationPage();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Location',
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
      body: new RefreshIndicator(
          child: new ListView(
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
                height: 400.0,
                width: double.infinity,
                child: PageView(
                  children: <Widget>[
                    LocationList(),
                  ],
                ),
              )
            ],
          ),
          onRefresh: refreshList
      )
      ,
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'Order',
        color: Colors.grey,
        selectedColor: Colors.red,
        notchedShape: CircularNotchedRectangle(),
        items: [
          FABBottomAppBarItem(
              iconData: Icons.menu, text: 'Home', page: 'homepage', index : 0),
          FABBottomAppBarItem(
              iconData: Icons.location_on, text: 'Location', page: 'location', index : 1),
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

