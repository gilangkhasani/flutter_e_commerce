import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget{
  @override
  _SignupPageSate createState()=>_SignupPageSate();
}
class _SignupPageSate extends State<SignUpPage>{
  String _email;
  String _password;
  String _phoneNumber;
  String _firstName;
  String _lastName;

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodePhoneNumber = FocusNode();
  final FocusNode focusNodeFirstName = FocusNode();
  final FocusNode focusNodeLastName = FocusNode();

  final formkey = new GlobalKey<FormState>();
  checkFields(){
    final form=formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  createUser()async{
    if (checkFields()){

    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

      appBar: AppBar(
        title: Image(image:AssetImage("images/flutter1.png",),
          height: 30.0,
          fit: BoxFit.fitHeight,),
        elevation: 0.0,

        centerTitle: true,
        backgroundColor: Colors.black12,

      ),
      body:ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 210.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/google2.gif'),
                    fit: BoxFit.contain),
                borderRadius: BorderRadius.only
                  (
                    bottomLeft: Radius.circular(500.0),
                    bottomRight: Radius.circular(500.0)
                )),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Center(
                  child: new Form(
                    key: formkey,
                    child: Center(
                      child: new ListView(
                        shrinkWrap: true,
                        children: <Widget>[

                          _input("required email",false,"Email",'Enter your Email', TextInputAction.next, TextInputType.emailAddress, focusNodeEmail, focusNodeFirstName, (value) => _email = value),
                          SizedBox(width: 20.0,height: 20.0,),
                          _input("required firstname",false,"Firstname",'Enter your Firstname', TextInputAction.next,TextInputType.text, focusNodeFirstName, focusNodeLastName, (value) => _firstName = value),
                          SizedBox(width: 20.0,height: 20.0,),
                          _input("required lastname",false,"Lastname",'Enter your Lastname', TextInputAction.next, TextInputType.text, focusNodeLastName, focusNodePhoneNumber, (value) => _lastName = value),
                          SizedBox(width: 20.0,height: 20.0,),
                          _input("required phonenumber",false,"PhoneNumber",'Enter your PhoneNumber', TextInputAction.next,TextInputType.number, focusNodePhoneNumber, focusNodePassword, (value) => _phoneNumber = value),
                          SizedBox(width: 20.0,height: 20.0,),
                          _input("required password",true,"Password",'Password', TextInputAction.done, TextInputType.text, focusNodePassword, null,  (value) => _password = value),

                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: <Widget>[
                                  OutlineButton(
                                    child: Text("Register"),
                                    onPressed: createUser,
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
        ],
      ) ,
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

