import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/fab_bottom_app_bar.dart';
import 'package:flutter_app/widgets/layout.dart';
import 'package:flutter_app/utils/database_order.dart';
import 'package:flutter_app/model/order.dart';
import 'package:flutter_app/utils/utility.dart';

class CheckoutPage extends StatefulWidget {

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<OrderClass> orderList;
  int count = 0;
  int sumTotal = 0;

  String _messages;
  String _subject;
  String _phoneNumber;
  String _name;

  final FocusNode focusNodeMessages = FocusNode();
  final FocusNode focusNodeSubject = FocusNode();
  final FocusNode focusNodePhoneNumber = FocusNode();
  final FocusNode focusNodeName = FocusNode();

  final formkey = new GlobalKey<FormState>();
  checkFields(){
    final form = formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  createReservation()async{
    if (checkFields()){

    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (orderList == null) {
      orderList = List<OrderClass>();
      getListData();
    }
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
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
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.grey)]),
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Your Cart",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              getOrderListView(context)
              ]
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.grey)]),
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Reservation Form",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.all(10.0),
                  child : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                          child: new Form(
                            key: formkey,
                            child: Center(
                              child: new ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  _input("required name",false,"Name",'Enter your Name', TextInputAction.next,TextInputType.text, focusNodeName, focusNodePhoneNumber, (value) => _name = value),
                                  SizedBox(width: 20.0,height: 20.0,),
                                  _input("required phonenumber",false,"PhoneNumber",'Enter your PhoneNumber', TextInputAction.next,TextInputType.number, focusNodePhoneNumber, focusNodeSubject, (value) => _phoneNumber = value),
                                  SizedBox(width: 20.0,height: 20.0,),
                                  _input("required subject",false,"Subject",'Enter your Subject', TextInputAction.next,TextInputType.text, focusNodeSubject, focusNodeMessages, (value) => _subject = value),
                                  SizedBox(width: 20.0,height: 20.0,),
                                  _input("required messages",false,"Messages",'Enter your Messages', TextInputAction.done,TextInputType.text, focusNodeMessages, null, (value) => _messages = value),
                                  SizedBox(width: 20.0,height: 20.0,),
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: <Widget>[
                                          OutlineButton(
                                            child: Text("Send"),
                                            onPressed: createReservation,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                  ),
                ),
              ])
          ),
        ],
      ),
      bottomNavigationBar: Builder(
        builder: (context) => _buildBottomNavigationBar(context),
      )
    );
  }

  ListView getOrderListView(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    //this.sumTotal = 0;
    int total = 0;

    return ListView.builder(
      itemCount: count,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int counter) {
        total = (this.orderList[counter].quantity_order *
            this.orderList[counter].product_price);
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: new Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                width: 120.0,
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: new NetworkImage(
                            "https://itbsjabartsel.com/resto/assets/images/" +
                                this.orderList[counter].product_image),
                        fit: BoxFit.cover)),
                height: 120.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      margin: EdgeInsets.all(5.0),
                      child: Text(
                        this.orderList[counter].product_name,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5.0),
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              "${orderList[counter].quantity_order}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Quicksand',
                                  fontSize: 18
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        "Rp. ${total}",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Quicksand',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _buildBottomNavigationBar(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 50.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text("Total \n Rp. " + sumTotal.toString()),
                )),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 5.0, 5.0),
                  child: RaisedButton(
                    onPressed: () {
                      //Navigator.of(context).pushNamed("/checkout");
                    },
                    color: Colors.pinkAccent,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            "Send",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            )
          ],
        ));
  }

  Widget _input(String validation,bool ,String label,String hint, textInputAction, keyboardType, focusNode, focus, save ){

    return new TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0)
        ),


      ),
      obscureText: bool,
      validator: (value)=>
      value.isEmpty ? validation: null,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onFieldSubmitted: (v){
        FocusScope.of(context).requestFocus(focus);
      },
      onSaved: save ,

    );

  }

  void getListData() {
    var dbFuture = databaseHelper.initializeDatabase();
    Future<List<OrderClass>> noteListFuture = databaseHelper.getOrderList();
    noteListFuture.then((orderList) {
      setState(() {
        this.orderList = orderList;
        this.count = orderList.length;
        getSumTotal();
      });
    });
  }

  void getSumTotal(){
    var dbFuture = databaseHelper.initializeDatabase();
    Future<List<OrderClass>> noteListFuture = databaseHelper.getOrderList();
    noteListFuture.then((orderList) {
      setState(() {
        this.sumTotal = 0;
        for(var i = 0; i < orderList.length; i++){
          this.sumTotal += (this.orderList[i].quantity_order * this.orderList[i].product_price);
        }
      });
    });
  }
}

