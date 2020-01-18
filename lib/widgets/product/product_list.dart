import 'package:flutter/material.dart';
import 'package:flutter_app/model/product.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/utils/uidata.dart';
import 'package:flutter_app/utils/utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/widgets/product/product_detail.dart';
import 'package:flutter_app/utils/database_order.dart';
import 'package:flutter_app/model/order.dart';
import 'package:intl/intl.dart';

class productList extends StatelessWidget {
  int categoryId;
  productList(int categoryId) : this.categoryId = categoryId;

  DatabaseHelper databaseHelper = DatabaseHelper();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //final dbFuture = databaseHelper.initializeDatabase();
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
            child: FutureBuilder<List<ProductClass>>(
              future: getProduct( http.Client(), 'search={"category_id" : ' + categoryId.toString() + '}'),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? ListProduct(product: snapshot.data)
                    : Center(child: CircularProgressIndicator());
              },
            )),
        SizedBox(
          height: 22.0,
        )
      ],
    );
  }
}

Future<List<ProductClass>> getProduct(http.Client client, search) async {
  final response = await client.get(UIData.apiUrl + "master/product?" + search);

  if (response.statusCode == 200) {
    // Use the compute function to run parsePhotos in a separate isolate
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
                builder: (context) => ProductDetail(item: product)));
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
                                "https://itbsjabartsel.com/resto/assets/images/" +
                                    product.product_image),
                            fit: BoxFit.cover)),
                    height: 70.0,
                  ),
                  Container(
                    child: Text(
                      product.product_name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Rp. " + product.product_price.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                    child: Center(
                      child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width * 0.9,
                        //padding: EdgeInsets.all(.0),
                        child: new RaisedButton(
                          child: Text('Add to Cart',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.0)),
                          color: Colors.pink,
                          elevation: 2.0,
                          splashColor: Colors.pinkAccent,
                          onPressed: () {

                            DateTime now = DateTime.now();
                            String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

                            var order = OrderClass(
                              order_id: 0,
                              order_date: formattedDate,
                              quantity_order : 1,
                              product_id: product.product_id,
                              product_name: product.product_name,
                              category_id: product.category_id,
                              product_description: product.product_description,
                              product_image: product.product_image,
                              product_price: product.product_price,
                            );

                            _save(context, order);

                          },
                        ),
                      ),
                    ),
                  ),
                ]),
          ))),
    );
  }

  void _save(BuildContext context, OrderClass order) async {

    DatabaseHelper databaseHelper = new DatabaseHelper();
    databaseHelper.initializeDatabase();
    int result = 0;
    List<OrderClass> cart;

    result = await databaseHelper.addToCart(order);
    Utility.snackShowCart(context, order.product_name + ' Has add to Cart');

  }
}

class ListProduct extends StatelessWidget {
  final List<ProductClass> product;

  ListProduct({Key key, this.product}) : super(key: key);

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
      itemCount: product.length,
      itemBuilder: (context, index) {
        return ProductCard(product: product[index]);
      },
    );
  }
}
