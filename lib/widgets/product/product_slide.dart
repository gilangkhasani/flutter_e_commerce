import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/product/product_detail.dart';
import 'package:flutter_app/model/product.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/utils/uidata.dart';
import 'package:flutter/foundation.dart';

class ProductSlide extends StatelessWidget {
  String search;
  ProductSlide(String search) : this.search = search;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<ProductClass>>(
          future: getProduct(http.Client(), search),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            print(snapshot);
            return snapshot.hasData
                ? ProductList(product: snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        )
      )
    );
  }
}

class ProductList extends StatelessWidget {
  final List<ProductClass> product;

  ProductList({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(5.0),
      scrollDirection: Axis.horizontal,
      children: List.generate(product.length, (index) {
        return Center(
          child: ProductCard(product: product[index]),
        );
      }),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({Key key, this.product}) : super(key: key);
  final ProductClass product;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetail(item: product ))
        );
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin:
              EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
              width: 120.0,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new NetworkImage("https://itbsjabartsel.com/resto/assets/images/" + product.product_image),
                      fit: BoxFit.cover)),
              height: 120.0,
            ),
            Container(
              child: Text(
                product.product_name,
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
    );
  }
}

Future<List<ProductClass>> getProduct(http.Client client, search) async {
  final response = await client.get(UIData.apiUrl + "master/product?" + search);

  if (response.statusCode == 200) {
    // Use the compute function to run parsePhotos in a separate isolate
    //return compute(parseProducts, response.body);
    return parseProducts(response.body);
  } else {
    throw Exception('Failed to load post');
  }

}

// A function that converts a response body into a List<ProductClass>
List<ProductClass> parseProducts(String responseBody) {
  final res = json.decode(responseBody);
  final parsed = res['result'].cast<Map<String, dynamic>>();

  return parsed
      .map<ProductClass>((json) => ProductClass.fromJson(json))
      .toList();
}
