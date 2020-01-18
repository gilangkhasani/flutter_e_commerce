import 'package:flutter/material.dart';

class ImageSlideDashboardItem {
  ImageSlideDashboardItem({this.urlImage, this.text, this.page});
  String urlImage;
  String text;
  String page;
}

class ImageSlideDashboard extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageSlideDashboardPage(),
    );
  }
}

class ImageSlideDashboardPage extends StatefulWidget {
  ImageSlideDashboardPage ({this.items}){}
  final List<ImageSlideDashboardItem> items;
  @override
  _ImageSlideDashboardState createState() => _ImageSlideDashboardState();
}

class _ImageSlideDashboardState extends State<ImageSlideDashboardPage> {

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
      );
    });
  }

  Widget _buildTabItem({
    ImageSlideDashboardItem item,
  }) {
    return ListView(
      padding: EdgeInsets.all(5.0),
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        itemCard(item.text, item.urlImage, item.page),
      ],
    );

  }

  Widget itemCard(String title, String imgPath, page) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin:
            EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            width: 120.0,
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    image: new NetworkImage(
                        imgPath),
                    fit: BoxFit.cover)),
            height: 120.0,
          ),
          Container(
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0),
            ),
          )
        ],
      ),
    );
  }
}