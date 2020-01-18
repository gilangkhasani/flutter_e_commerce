import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/fab_bottom_app_bar.dart';
import 'package:flutter_app/widgets/layout.dart';

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {

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
          'Reservation',
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
            height: 5.0,
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
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                      child: Text(
                        'Untuk informasi, booking online, saran dan kritik, atau ingin mengetahui lebih lanjut tentang kami, silakan isi form berikut ini: \nAtau hubungi kami untuk reservasi di 081214234772',
                        textAlign: TextAlign.justify,
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
            ]),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
          margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.grey)]),
            child: Column(children: <Widget>[
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
              iconData: Icons.person, text: 'About Us', page: 'accountpage', index : 0),
          FABBottomAppBarItem(
              iconData: Icons.local_phone, text: 'Reservation', page: 'accountpage', index : 1),
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
}

