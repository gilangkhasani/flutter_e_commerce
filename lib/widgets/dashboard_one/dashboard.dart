import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/dashboard_one/dashboard_menu_row.dart';
import 'package:flutter_app/widgets/profile/profile_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_app/widgets/fab_bottom_app_bar.dart';
import 'package:flutter_app/widgets/layout.dart';

class Dashboard extends StatelessWidget {

  AnimationController animationController;
  Animation animation;

  Size deviceSize;
  int photoindex = 0;
  List<String> photos = [
    "images/flutter1.png",
    "images/Logomark.png",
    "images/google1.png",
    "images/dart.png",
    "images/bird.jpg"
  ];

  Widget slideBarColumn(BuildContext context) => Stack(
    children: <Widget>[
      Container(
        height: 110.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(photos[photoindex]),
                fit: BoxFit.scaleDown)),
      ),
      Positioned(
        top: 180.0,
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
  );

  Widget appBarColumn(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18.0),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new ProfileTile(
                  title: "Hi, Pawan Kumar",
                  subtitle: "Welcome to the Flutter UIKit",
                  textColor: Colors.black,
                  textAlign: TextAlign.center
              ),
            ],
          ),
        ],
      ),
    ),
  );

  Widget searchCard() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.search),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Find our product"),
              ),
            ),
            Icon(Icons.menu),
          ],
        ),
      ),
    ),
  );

  Widget actionMenuCard() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              DashboardMenuRow(
                firstIcon: FontAwesomeIcons.solidUser,
                firstLabel: "Friends",
                firstIconCircleColor: Colors.blue,
                secondIcon: FontAwesomeIcons.userFriends,
                secondLabel: "Groups",
                secondIconCircleColor: Colors.orange,
                thirdIcon: FontAwesomeIcons.mapMarkerAlt,
                thirdLabel: "Nearby",
                thirdIconCircleColor: Colors.purple,
                fourthIcon: FontAwesomeIcons.locationArrow,
                fourthLabel: "Moment",
                fourthIconCircleColor: Colors.indigo,
              ),
              DashboardMenuRow(
                firstIcon: FontAwesomeIcons.images,
                firstLabel: "Albums",
                firstIconCircleColor: Colors.red,
                secondIcon: FontAwesomeIcons.solidHeart,
                secondLabel: "Likes",
                secondIconCircleColor: Colors.teal,
                thirdIcon: FontAwesomeIcons.solidNewspaper,
                thirdLabel: "Articles",
                thirdIconCircleColor: Colors.lime,
                fourthIcon: FontAwesomeIcons.solidCommentDots,
                fourthLabel: "Reviews",
                fourthIconCircleColor: Colors.amber,
              ),
              DashboardMenuRow(
                firstIcon: FontAwesomeIcons.footballBall,
                firstLabel: "Sports",
                firstIconCircleColor: Colors.cyan,
                secondIcon: FontAwesomeIcons.solidStar,
                secondLabel: "Fav",
                secondIconCircleColor: Colors.redAccent,
                thirdIcon: FontAwesomeIcons.blogger,
                thirdLabel: "Blogs",
                thirdIconCircleColor: Colors.pink,
                fourthIcon: FontAwesomeIcons.wallet,
                fourthLabel: "Wallet",
                fourthIconCircleColor: Colors.brown,
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget allCards(BuildContext context) => SingleChildScrollView(
    child: Column(
      children: <Widget>[
        slideBarColumn(context),
        SizedBox(
          height: deviceSize.height * 0.01,
        ),
        appBarColumn(context),
        SizedBox(
          height: deviceSize.height * 0.01,
        ),
        actionMenuCard(),
        SizedBox(
          height: deviceSize.height * 0.01,
        ),
      ],
    ),
  );

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
          Navigator.of(context).pushNamed("/loginpage");
        },
        tooltip: 'Increment',
        child: Icon(Icons.camera),
        elevation: 2.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/loginpage");
            }),
      ),
      body: new ListView(
        //fit: StackFit.expand,
        children: <Widget>[
          Stack(
            children: <Widget>[allCards(context)],
          ),
        ],
      ),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'Scan QR',
        color: Colors.grey,
        selectedColor: Colors.red,
        notchedShape: CircularNotchedRectangle(),
        items: [
          FABBottomAppBarItem(
              iconData: Icons.menu, text: 'Home', page: 'homepage'),
          FABBottomAppBarItem(
              iconData: Icons.layers, text: 'Users', page: 'accountpage'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(
          context), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
