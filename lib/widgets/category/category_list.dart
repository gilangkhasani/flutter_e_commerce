import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/product/product.dart';
import 'package:flutter_app/model/category.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/utils/uidata.dart';
import 'package:flutter/foundation.dart';

class CategoryList extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListView(
          shrinkWrap: true,
          children: <Widget>[
            SafeArea(
              bottom: true,
              child: Column(
                children: <Widget>[
                  Container(
                      height: 350,
                      width: double.infinity,
                      child: FutureBuilder<List<CategoryClass>>(
                        future: getCategory(http.Client()),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) print(snapshot.error);

                          return snapshot.hasData
                              ? ListCategory(category: snapshot.data)
                              : Center(child: CircularProgressIndicator());
                        },
                      )
                  ),
                  SizedBox(
                    height: 22.0,
                  )
                ],
              ),
            ),
          ],
        );
  }
}

Future<List<CategoryClass>> getCategory(http.Client client) async {
  final response = await client.get(UIData.apiUrl + "master/category");

  if (response.statusCode == 200) {
    // Use the compute function to run parsePhotos in a separate isolate
    return parseCategories(response.body);
  } else {
    throw Exception('Failed to load post');
  }

}

// A function that converts a response body into a List<ProductClass>
List<CategoryClass> parseCategories(String responseBody) {
  final res = json.decode(responseBody);
  final parsed = res['result'].cast<Map<String, dynamic>>();

  return parsed
      .map<CategoryClass>((json) => CategoryClass.fromJson(json))
      .toList();
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key key, this.category}) : super(key: key);
  final CategoryClass category;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductPage(item: category)),
        );
      },
      child: (Card(
          color: Colors.white,
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                            image: new NetworkImage(
                                "https://itbsjabartsel.com/resto/assets/images/" + category.category_image),
                            fit: BoxFit.cover)),
                    height: 70.0,
                  ),
                  Container(
                    child: Text(
                      category.category_name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0),
                    ),
                  )
                ]),
          ))),
    );
  }
}

class ListCategory extends StatelessWidget {
  final List<CategoryClass> category;

  ListCategory({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 10.0,
      ),
      padding: const EdgeInsets.all(10.0),
      itemCount: category.length,
      itemBuilder: (context, index) {
        return CategoryCard(category: category[index]);
      } ,
    );
  }
}

