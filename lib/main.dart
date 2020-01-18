import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/login/loginPage.dart';
import 'package:flutter_app/widgets/signup/signup.dart';
import 'package:flutter_app/widgets/homepage/homepage.dart';
import 'package:flutter_app/widgets/about_us/about_us.dart';
import 'package:flutter_app/widgets/category/category.dart';
import 'package:flutter_app/widgets/product/product_detail.dart';
import 'package:flutter_app/widgets/location/location.dart';
import 'package:flutter_app/widgets/location/location_detail.dart';
import 'package:flutter_app/widgets/reservation/reservation.dart';
import 'package:flutter_app/widgets/cart/cart.dart';
import 'package:flutter_app/widgets/checkout/checkout.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "Dermaga Resto",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Page(),
      routes: <String, WidgetBuilder>{
        "/loginpage": (BuildContext context) => new LoginPage(),
        "/signup": (BuildContext context) => new SignUpPage(),
        "/homepage": (BuildContext context) => new Page(),
        "/accountpage": (BuildContext context) => new AccountPage(),
        "/category": (BuildContext context) => new CategoryPage(),
        "/product": (BuildContext context) => new ProductDetail(),
        "/location": (BuildContext context) => new LocationPage(),
        "/location_detail": (BuildContext context) => new LocationDetailPage(),
        "/reservation": (BuildContext context) => new ReservationPage(),
        "/cart": (BuildContext context) => new CartPage(),
        "/checkout": (BuildContext context) => new CheckoutPage(),
      },
    );
  }
}
