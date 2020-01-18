import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/fab_bottom_app_bar.dart';
import 'package:flutter_app/widgets/layout.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {

  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    animationController =
        new AnimationController(duration: Duration(seconds: 10), vsync: this);
    animation =
        IntTween(begin: 0, end: photos.length - 1).animate(animationController)
          ..addListener(() {
            setState(() {
              photoindex = animation.value;
            });
          });
    animationController.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
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
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'About Us',
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
              Positioned(
                top: 80.0,
                left: 5.0,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 2.0),
                    Text(
                      '4.0',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 4.0),

                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.0,
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
                  'Darmaga Sunda Resto is a restaurant that serves typical Sundanese food located food located on KM 36 Bandung-Garut St., Nagreg, Bandung. \nWe are a restaurant that has uniqueness becausewe combine the concept of a place to eat with recreation.\nAs the name implies, we present a placeto eat with the atsmosphere surrounded by docks and lush tress.\nWe also have a boat-shaped dining area so guest who come will feel the sensation of eating while rideing the boat.\nWe also present the spot of interesting photographs of the contemporary and Instagram-able. \nFocus on selling the concept of recreation, does not make us forget the taste of typical Sundanese food that we serve. \nSundanese specialties that we serve are typical foods with great pleasure and will make your tongue sway.\nWe have a variety of typical menus, including the mainstay menu Darmaga Sunda such as “Gulai Kepala Kakap Kuah Merah”,“Sup Gurame Goreng Asam Pedas”, and others. \nWe also provide special food packages for Children because we bring Darmaga Sunda not only for you but also for the family.\nCall us at 081214234772 for reservation!',
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
              iconData: Icons.person, text: 'About Us', page: 'accountpage', index : 1),
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
          //Navigator.of(context).pushNamed("/category");
          Navigator.pushNamed(context, '/category');
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}

