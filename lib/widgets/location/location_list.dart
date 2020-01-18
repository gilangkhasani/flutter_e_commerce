import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/location/location_detail.dart';
import 'package:flutter_app/model/location.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/utils/uidata.dart';
import 'package:flutter/foundation.dart';

class LocationList extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Location ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                ],
              ),
            ),
            Container(
              height: 400,
              width: double.infinity,
              child: FutureBuilder<List<LocationClass>>(
                future: getLocation(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? ListLocation(location: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<LocationClass>> getLocation(http.Client client) async {
  final response = await client.get(UIData.apiUrl + "master/location");

  if (response.statusCode == 200) {
    // Use the compute function to run parsePhotos in a separate isolate
    return parseLocation(response.body);
  } else {
    throw Exception('Failed to load post');
  }

}

// A function that converts a response body into a List<ProductClass>
List<LocationClass> parseLocation(String responseBody) {
  final res = json.decode(responseBody);
  final parsed = res['result'].cast<Map<String, dynamic>>();

  return parsed
      .map<LocationClass>((json) => LocationClass.fromJson(json))
      .toList();
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key key, this.location}) : super(key: key);
  final LocationClass location;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LocationDetailPage(item: location)),
        );
      },
      child: (Container(
        margin: EdgeInsets.all(5.0),
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 70.0,
                height: 80.0,
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: new NetworkImage(location.location_image),
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(width: 30.0),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      location.location_name,
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 45.0),
                  ],
                ),
                SizedBox(height: 5.0),
                Container(
                  width: 175.0,
                  child: Text(
                    location.location_description,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.grey,
                        fontSize: 12.0),
                  ),
                ),
                SizedBox(height: 5.0),
              ],
            )
          ],
        ),
      )),
    );
  }
}

class ListLocation extends StatelessWidget {
  final List<LocationClass> location;

  ListLocation({Key key, this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: location.length,
        itemBuilder: (context, index) {
          return LocationWidget(location: location[index]);
        }
    );
  }
}

